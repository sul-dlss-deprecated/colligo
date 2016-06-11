module AnnotationData
  include JsonReader
  extend ActiveSupport::Concern

  def read_annotation(url = nil)
    return nil unless url # self[:annotation_url]
    @annotation_list = JsonReader::Reader.new.from_url(url)
  end

  def motivation_for_annotations
    'oa:commenting'
  end

  def motivation_for_transcriptions
    'sc:painting'
  end

  def resources(annotation_list = nil)
    return [] unless annotation_list
    return [] unless annotation_list.key? 'resources'
    annotation_list['resources']
  end

  def annotations(annotation_list = nil)
    # the motivation for annotations will be: "oa:commenting"
    # return [] unless self[:annotation_url]
    # self.read_annotation unless self[:annotation_list]
    # return [] unless self[:annotation_list]
    # return self[:annotation_list][:resources].select {|anno| anno["motivation"] == "oa:commenting" }
    al = resources(annotation_list)
    return [] unless al
    al.select { |anno| anno['motivation'] == motivation_for_annotations }
  end

  def transcriptions(annotation_list = nil)
    # the motivation for transcriptions will be: "sc:painting"
    # return [] unless self[:annotation_url]
    # self.read_annotation unless self[:annotation_list]
    # return [] unless self[:annotation_list]
    # return self[:annotation_list][:resources].select {|anno| anno["motivation"] == "sc:painting" }
    al = resources(annotation_list)
    return [] unless al
    al.select { |anno| anno['motivation'] == motivation_for_transcriptions }
  end

  def map_annotation(annotation = nil)
    return {} unless annotation
    anno = {}
    anno['id'] = annotation['@id']
    anno['target_type'] = annotation['@type']
    anno['motivation'] = annotation['motivation']
    anno['target_url'] = annotation['on']
    anno['body_type'] = annotation['resource']['@type']
    # TODO: Convert format to human form?
    anno['body_format'] = annotation['resource']['format']
    anno['body_chars'] = annotation['resource']['chars']
    if SEARCHWORKS_LANGUAGES.key?(annotation['resource']['language'])
      anno['body_language'] = SEARCHWORKS_LANGUAGES[annotation['resource']['language']]
    else
      anno['body_language'] = annotation['resource']['language']
    end
    anno['model'] = 'Transcription' if annotation['motivation'] == motivation_for_transcriptions
    anno['model'] = 'Annotation' if annotation['motivation'] == motivation_for_annotations
    anno
  end

  def annotation_to_solr(data = {})
    # data.keys = [:annotation, :manuscript, :folio, :url, :img_info]
    return {} unless data.key?('annotation') || data['annotation']
    anno = map_annotation(data['annotation'])
    return {} unless anno['id']
    solr_doc = {}
    solr_doc['id'] = anno['id']
    solr_doc['druid'] = self['druid']
    solr_doc['manifest_urls'] = self['iiif_manifest']
    solr_doc['collection'] = self['collection']
    solr_doc['sort_index'] = self['sort_index']
    solr_doc['url_sfx'] = data['url'] if data.key?('url')
    solr_doc['folio'] = data['folio'] if data.key?('folio')
    solr_doc['img_info'] = data['img_info'].uniq if data.key?('img_info')
    solr_doc['manuscript_search'] = data['manuscript'] if data.key?('manuscript')
    solr_doc['model'] = anno['model']
    solr_doc['motivation'] = anno['motivation']
    solr_doc['target_url'] = anno['target_url']
    solr_doc['target_type'] = anno['target_type']
    solr_doc['body_type'] = anno['body_type']
    solr_doc['format'] = anno['body_format']
    solr_doc['body_chars_search'] = anno['body_chars']
    solr_doc['language'] = anno['body_language']
    solr_doc
  end
end
