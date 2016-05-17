# -*- encoding : utf-8 -*-
class BookmarksController < CatalogController

  include Blacklight::Bookmarks
  include Colligo::SearchManuscripts

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

end
