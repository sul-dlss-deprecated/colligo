class FolioController < ApplicationController
  include Blacklight::Configurable
  include Blacklight::SolrHelper
  include Blacklight::Catalog::SearchContext
  copy_blacklight_config_from(CatalogController)
  blacklight_config.max_per_page = 1000

  layout 'blacklight'

  def show
    # Get all transcriptions and annotations
    annotations
    transcriptions
    # If no annotation or transcriptions redirect to manuscript page
    if @annotations.blank? && @transcriptions.blank?
      flash[:notice] = "There are no transcriptions or annotations for folio #{params[:id]}"
      redirect_to manuscript_path(params[:manuscript_id]) and return #
    end
    # Set a value for the active tab
    if !params.has_key?(:view) && @annotations.present?
      params[:view] = 'annotations'
    elsif !params.has_key?(:view) && @transcriptions.present?
      params[:view] = 'transcriptions'
    elsif !params.has_key?(:view) || params[:view].blank?
      params[:view] = 'annotations'
    end
    params[:view] = 'annotations' unless %w(annotations transcriptions).include?(params[:view])
    # Get details of manuscript
    manuscript
    # Get current canvas id, previous and next folio
    current_prev_and_next_folio
    respond_to do |format|
      format.html do
        render
      end
    end
  end

  private

  def annotations
    query_params = { q: "druid:#{params[:manuscript_id]} AND folio:\"#{params[:id]}\"", rows: 1000, sort: 'sort_index asc' }
    self.search_params_logic += [:add_annotation_filter]
    self.search_params_logic -= [:all_search_filter, :add_manuscript_filter, :add_transcription_filter]
    (_resp, @annotations) = search_results(query_params, self.search_params_logic)
  end

  def transcriptions
    query_params = { q: "druid:#{params[:manuscript_id]} AND folio:\"#{params[:id]}\"", rows: 1000, sort: 'sort_index asc' }
    self.search_params_logic += [:add_transcription_filter]
    self.search_params_logic -= [:all_search_filter, :add_manuscript_filter, :add_annotation_filter]
    (_resp, @transcriptions) = search_results(query_params, self.search_params_logic)
  end

  def manuscript
    query_params = { q: "druid:#{params[:manuscript_id]}", rows: 1 }
    self.search_params_logic += [:add_manuscript_filter]
    self.search_params_logic -= [:all_search_filter, :add_annotation_filter, :add_transcription_filter]
    (_resp, doc) = search_results(query_params, self.search_params_logic)
    @manuscript = doc.first if doc
  end

  def canvas_id
    # The canvas id in the annotations target can be different from the manifest
    #   - using the one from the manifest - see current_prev_and_next_folio
    if @annotations.present?
      @canvas_id = @annotations[0]['target_url'][0].split('#')[0]
    elsif @transcriptions.present?
      @canvas_id = @transcriptions[0]['target_url'][0].split('#')[0]
    end
  end

  def current_prev_and_next_folio
    # TODO: For now I am downloading manifest - I should just index the manifest
    # The canvas id in the annotations can be different from the manifest - using the one in the manifest
    # This method subsumes the method canvas_id
    contents = []
    contents = IiifManifest.new(@manuscript['manifest_urls'].first).contents unless @manuscript['manifest_urls'].blank?
    @previous_folio = nil
    @next_folio = nil
    @canvas_id = nil
    page_number = contents.index {|c| c['label'] == params[:id]}
    @canvas_id = contents[page_number]['@id'] if page_number
    @previous_folio = contents[page_number-1] if page_number && page_number > 0
    @next_folio = contents[page_number+1] if page_number && page_number < contents.length
  end

end