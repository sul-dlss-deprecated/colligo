module ModsData
  extend ActiveSupport::Concern  
  included do
    include ModsDisplay::ModelExtension
    include ModsDisplay::ControllerExtension
    mods_xml_source do |model|
      model[:modsxml]
    end
    configure_mods_display do
    end
  end

  #attr_accessor :id, :purl, :collection, :manifest

  #define_model_callbacks :save, :destroy
  #after_save :add_to_index
  #before_destroy :remove_from_index

  def mods
    return nil unless self[:modsxml]
    @mods ||= render_mods_display(self)
  end

  def mods_raw
    return nil unless self[:modsxml]
    @mods_data = Stanford::Mods::Record.new
    @mods_data.from_str(self[:modsxml])
  end

  def prettified_mods
    return nil unless self["modsxml"]
    @prettified_mods ||= CodeRay::Duo[:xml, :div].highlight(self["modsxml"]).html_safe
  end

  def mods_to_solr
    data = self.mods_raw
    return {} unless data
    return {} unless self["id"]
    solr_doc = {}
    solr_doc["id"] = self["id"]
    solr_doc["druid"] = self["id"]
    solr_doc["url_sfx"] = self["purl"]
    solr_doc["manifest_urls"] = self["manifest"]
    solr_doc["collection"] = self.collection
    solr_doc["abstract_search"] = data.abstract.text
    solr_doc["access_condition_search"] = data.accessCondition.text
    solr_doc["genre_search"] = data.sw_genre
    type_of_resource = []
    data.typeOfResource.attributes.each do |t|
        type_of_resource << t.keys[0] if t.keys and t.keys[0]
    end
    solr_doc["type_of_resource_search"] = type_of_resource
    solr_doc["corporate_authors_search"] = (data.sw_corporate_authors).uniq
    solr_doc["personal_authors_search"] = (data.sw_person_authors).uniq
    solr_doc["title_search"] = data.sort_title
    solr_doc["title_alternate_search"] = data.alternative_titles
    solr_doc["title_other_search"] = data.full_titles - [data.sort_title] - data.alternative_titles
    #solr_doc["subtitle_search"] = data.subtitle
    solr_doc["language"] = data.languages
    #solr_doc["physical_description_extent_display"] = data.physical_description_extent
    #solr_doc["physical_description_form_search"] = data.physical_description_form
    #solr_doc["physical_description_media_type_search"] = data.physical_description_media_type
    solr_doc["physical_location_display"] = data.location.physicalLocation.text
    #solr_doc["location_url_display"] = data.location_url
    #solr_doc["relateditem_location_url_display"] = data.relateditem_location_url
    #solr_doc["relateditem_title_search"] = data.relateditem_title
    solr_doc["pub_date"] = data.pub_dates
    solr_doc["pub_date_t"] = data.pub_date_facet
    solr_doc["pub_year_t"] = data.pub_year
    #solr_doc["publishers_search"] = data.publishers
    solr_doc["place_search"] = data.place
    solr_doc["topic_search"] = data.topic_search
    solr_doc["geographic_search"] = data.geographic_facet
    solr_doc["era_search"] = data.era_facet
    solr_doc["subject_other_search"] = data.subject_other_search
    solr_doc["subject_all_search"] = data.subject_all_search
    solr_doc["format"] = data.format
    solr_doc
  end

end
