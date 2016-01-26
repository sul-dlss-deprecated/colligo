class TestController < ApplicationController
  include Blacklight::Configurable
  include Blacklight::SolrHelper
  include Blacklight::Catalog::SearchContext
  copy_blacklight_config_from(CatalogController)

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
    # Get current canvas id
    canvas_id
    # Get previous and next folio
    prev_and_next_folio
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
    (_resp, @annotations) = get_search_results(query_params)
  end

  def transcriptions
    query_params = { q: "druid:#{params[:manuscript_id]} AND folio:\"#{params[:id]}\"", rows: 1000, sort: 'sort_index asc' }
    self.search_params_logic += [:add_transcription_filter]
    self.search_params_logic -= [:all_search_filter, :add_manuscript_filter, :add_annotation_filter]
    (_resp, @transcriptions) = get_search_results(query_params)
  end

  def manuscript
    query_params = { q: "druid:#{params[:manuscript_id]}", rows: 1 }
    self.search_params_logic += [:add_manuscript_filter]
    self.search_params_logic -= [:all_search_filter, :add_annotation_filter, :add_transcription_filter]
    (_resp, doc) = get_search_results(query_params)
    @manuscript = doc.first if doc
  end

  def canvas_id
    if @annotations.present?
      @canvas_id = @annotations[0]['target_url'][0].split('#')[0]
    elsif @transcriptions.present?
      @canvas_id = @transcriptions[0]['target_url'][0].split('#')[0]
    end
  end

  def prev_and_next_folio
    # TODO: For now I am downloading manifest - I should just index the manifest
    contents = []
    contents = IiifManifest.new(@manuscript['manifest_urls'].first).contents unless @manuscript['manifest_urls'].blank?
    @previous_folio = nil
    @next_folio = nil
    page_number = contents.index {|c| c['label'] == params[:id]}
    @previous_folio = contents[page_number-1] if page_number && page_number > 0
    @next_folio = contents[page_number+1] if page_number && page_number < contents.length
  end

end