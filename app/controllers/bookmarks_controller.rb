# -*- encoding : utf-8 -*-
class BookmarksController < CatalogController

  include Blacklight::Bookmarks

  def index
    @bookmarks = token_or_current_or_guest_user.bookmarks
    bookmark_ids = @bookmarks.collect { |b| b.document_id.to_s }

    @response_m, @document_list_m = fetch(bookmark_ids)
    related_annotations
    related_transcriptions
    respond_to do |format|
      format.html { }
      format.rss  { render :layout => false }
      format.atom { render :layout => false }
      format.json do
        render json: render_search_results_as_json
      end

      additional_response_formats(format)
      document_export_formats(format)
    end
  end

  private

  def related_annotations
    @related_annotations = {}
    @document_list_m.each do |doc|
      query_params = { q: "manuscript_search:\"#{doc['title_display']}\"", rows: 0 }
      self.search_params_logic += [:add_annotation_filter]
      self.search_params_logic -= [:all_search_filter, :add_manuscript_filter, :add_transcription_filter]
      (resp, _doc_list) = search_results(query_params, self.search_params_logic)
      @related_annotations[doc['druid']] = resp['response']['numFound']
    end
  end

  def related_transcriptions
    @related_transcriptions = {}
    @document_list_m.each do |doc|
      query_params = { q: "manuscript_search:\"#{doc['title_display']}\"", rows: 0 }
      self.search_params_logic += [:add_transcription_filter]
      self.search_params_logic -= [:all_search_filter, :add_manuscript_filter, :add_annotation_filter]
      (resp, _doc_list) = search_results(query_params, self.search_params_logic)
      @related_transcriptions[doc['druid']] = resp['response']['numFound']
    end
  end

end
