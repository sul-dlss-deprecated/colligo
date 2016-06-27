# -*- encoding : utf-8 -*-
module Colligo::SearchManuscripts
  extend ActiveSupport::Concern

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
