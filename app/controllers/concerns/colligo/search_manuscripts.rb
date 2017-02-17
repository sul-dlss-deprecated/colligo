# -*- encoding : utf-8 -*-
module Colligo::SearchManuscripts
  extend ActiveSupport::Concern

  def related_annotations
    @related_annotations = {}
    @document_list_m.each do |doc|
      query_params = { q: "manuscript_search:\"#{doc['title_display']}\"", rows: 0 }
      (resp, _doc_list) = search_results(query_params) do |search_builder|
        search_builder.append(:add_annotation_filter)
      end
      @related_annotations[doc['druid']] = resp['response']['numFound']
    end
  end

  def related_transcriptions
    @related_transcriptions = {}
    @document_list_m.each do |doc|
      query_params = { q: "manuscript_search:\"#{doc['title_display']}\"", rows: 0 }
      (resp, _doc_list) = search_results(query_params) do |search_builder|
        search_builder.append(:add_transcription_filter)
      end
      @related_transcriptions[doc['druid']] = resp['response']['numFound']
    end
  end
end
