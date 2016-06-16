# -*- encoding : utf-8 -*-
# Module to extract all of the data from a iiif manifest to index in solr
class SolrDocument
  include ModsData
  include AnnotationData
  include Blacklight::Solr::Document

  attr_accessor :druid, :iiif_manifest, :collection, :mods_url, :manuscript, :thumbnail

  def initialize(*args)
    super
  end

  field_semantics.merge!(
    title: 'title_display',
    author: 'author_display',
    language: 'language_facet',
    format: 'format'
  )

  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)
  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)
end
