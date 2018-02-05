# Model for the mods linked in the IIIF manifest
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

  # attr_accessor :id, :purl, :collection, :manifest

  # define_model_callbacks :save, :destroy
  # after_save :add_to_index
  # before_destroy :remove_from_index

  # render mods for display
  def mods
    return nil unless self[:modsxml]
    @mods ||= render_mods_display(self)
  end

  # fetch the mods xml data
  def mods_raw
    return nil unless self[:modsxml]
    @mods_data = Stanford::Mods::Record.new
    @mods_data.from_str(self[:modsxml])
  end

  # fetch the mods data in pretty xml
  def prettified_mods
    return nil unless self['modsxml']
    @prettified_mods ||= CodeRay::Duo[:xml, :div].highlight(self['modsxml']).html_safe
  end

  # list of display fileds of interest to Colligo
  def all_display_fields
    %w( title_display abstract_display img_info druid model manifest_urls
        title_alternate_display title_other_display subtitle_display corporate_authors_display
        personal_authors_display authors_all_display collection topic_display geographic_display
        subject_other_display subject_all_display genre_display era_display pub_date_display
        place_display physical_description_extent_display physical_description_form_display
        physical_description_media_type_display publishers_display type_of_resource_display
        physical_location_display access_condition_display language)
  end

  # list of single valued fields in the mods
  def single_valued_display_fields
    %w(title_display abstract_display subtitle_display pub_date_display access_condition_display)
  end

  # method to index the mods data
  def mods_to_solr
    data = mods_raw
    return {} unless data
    return {} unless self['druid']
    solr_doc = {}
    solr_doc['id'] = self['druid']
    solr_doc['druid'] = self['druid']
    solr_doc['url_sfx'] = self['mods_url']
    solr_doc['manifest_urls'] = self['iiif_manifest']
    solr_doc['collection'] = self['collection']
    solr_doc['model'] = 'Manuscript'
    solr_doc['img_info'] = self['thumbnail']
    solr_doc['abstract_search'] = data.abstract.text
    solr_doc['access_condition_search'] = data.accessCondition.text
    solr_doc['genre_search'] = data.sw_genre
    type_of_resource = []
    data.typeOfResource.attributes.each do |t|
      type_of_resource << t.keys[0] if t.keys && t.keys[0]
    end
    data.typeOfResource.each do |t|
      type_of_resource << t.text if t.text
    end
    solr_doc['type_of_resource_search'] = type_of_resource.uniq
    solr_doc['corporate_authors_search'] = data.sw_corporate_authors.uniq
    solr_doc['personal_authors_search'] = data.sw_person_authors.uniq
    solr_doc['authors_all_search'] = (data.sw_person_authors + data.sw_impersonal_authors).uniq
    solr_doc['title_search'] = data.sort_title
    solr_doc['title_alternate_search'] = data.alternative_titles
    solr_doc['title_other_search'] = data.full_titles - [data.sort_title] - data.alternative_titles
    solr_doc['language'] = data.languages
    solr_doc['physical_location_display'] = []
    data.location.physicalLocation.each do |p|
      solr_doc['physical_location_display'] << p.text
    end
    # All of the pub dates
    solr_doc['pub_dates'] = data.pub_dates
    dates = parse_dates(data.pub_dates)
    # All the pub dates in int years
    solr_doc['pub_date'] = dates[:all_int]
    # All the pub dates in int years
    solr_doc['pub_date_t'] = dates[:all_int]
    # average of pub dates for sort
    solr_doc['pub_date_sort'] = dates[:sort].presence
    # pub date for display
    solr_doc['pub_date_display'] = display_date(data.pub_dates)
    solr_doc['place_search'] = data.place
    solr_doc['topic_search'] = data.topic_search
    solr_doc['geographic_search'] = data.geographic_facet
    solr_doc['era_search'] = data.era_facet
    solr_doc['subject_other_search'] = data.subject_other_search
    solr_doc['subject_all_search'] = data.subject_all_search
    solr_doc['format'] = data.format
    # TODO: May need to extract the following data from MODS
    # solr_doc["subtitle_search"] = data.subtitle
    # solr_doc["physical_description_extent_display"] = data.physical_description_extent
    # solr_doc["physical_description_form_search"] = data.physical_description_form
    # solr_doc["physical_description_media_type_search"] = data.physical_description_media_type
    # solr_doc["location_url_display"] = data.location_url
    # solr_doc["relateditem_location_url_display"] = data.relateditem_location_url
    # solr_doc["relateditem_title_search"] = data.relateditem_title
    # solr_doc["publishers_search"] = data.publishers
    solr_doc
  end

  protected

  # Parse the different date formats used across the mods
  # 1. Year                            ["1389"]                        (eg: mr892jv0716)
  # 2. Start and end years             ["850","1499"]                  (eg: kh686yw0435)
  # 3. Approximate year                ["Ca. 1580 CE"]                 (eg: gs755tr2814)
  # 4. Approximate year                ["1500 CE"]                     (eg: hp976mx6580)
  # 5. Approximate century             ["14uu"]                        (eg: tw490xj0071)
  # 6. Full date                       ["February 6, 1486"]            (eg: ss222gr9703)
  # 7. Partial date                    ["June 1781"]                   (eg: zq824dz1346)
  # 8. Approximate start and end years ["s. XIII^^ex [ca. 1275-1300]"] (eg: rc145sy7436)
  def parse_dates(input_dates)
    dates = { all_int: [], sort: '' }
    return dates if input_dates.blank?
    input_dates.each do |dt|
      dates[:all_int] << dt.to_s.scan(/[0-9]{3,4}/)
      centuries = dt.to_s.scan(/([0-9]{2})[uU]{2}/)
      unless centuries.blank?
        dates[:all_int] << centuries[0].map { |c| (c.to_i * 100).to_s }
        dates[:all_int] << centuries[0].map { |c| (c.to_i * 100 + 99).to_s }
      end
    end
    dates[:all_int].flatten!
    unless dates[:all_int].blank?
      dates[:all_int] = dates[:all_int].map(&:to_i)
      dates[:sort] = (dates[:all_int].inject { |sum, x| sum + x }) / dates[:all_int].length
    end
    dates
  end

  # join the different dates and return a string (example: start and end dates)
  def display_date(input_dates)
    return '' if input_dates.blank?
    input_dates.delete_if(&:blank?)
    if input_dates.length <= 2
      input_dates.map(&:to_s).join(' to ')
    else
      input_dates.map(&:to_s).join(', ')
    end
  end
end
