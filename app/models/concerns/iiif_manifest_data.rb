module IiifManifestData
  include JsonReader
  extend ActiveSupport::Concern

  attr_accessor :manifest_url, :manifest, :modsxml, :thumbnail

  def read_manifest
    return nil unless self.manifest_url
    self.manifest = JsonReader::Reader.new.from_url(self.manifest_url)
  end

  def title
    return nil unless self.manifest_url
    self.read_manifest unless self.manifest 
    return nil unless self.manifest
    self.manifest["label"]
  end

  def druid
    #druid is a 11 digit alphanumeric sring
    return nil unless self.manifest_url
    self.read_manifest unless self.manifest 
    return nil unless self.manifest
    self.manifest["@id"].match( /\/([a-zA-Z0-9]{11})\// ).to_s.gsub('/', '')
  end

  def thumbnail
    return nil unless self.manifest_url
    self.read_manifest unless self.manifest
    return nil unless self.manifest
    return nil unless self.manifest.has_key?("thumbnail")
    self.manifest["thumbnail"]["@id"]
  end

  def mods_url
    return nil unless self.manifest_url
    self.read_manifest unless self.manifest 
    return nil unless self.manifest
    return nil unless self.manifest.has_key?("seeAlso")
    if self.manifest["seeAlso"]["dcterms:format"] == "application/mods+xml"
      return self.manifest["seeAlso"]["@id"]
    elsif self.manifest["seeAlso"]["format"] == "application/mods+xml"
      return self.manifest["seeAlso"]["@id"]
    end
    return nil
  end

  def annotation_lists
    return [] unless self.manifest_url
    self.read_manifest unless self.manifest 
    return [] unless self.manifest
    annotations = []
    self.manifest["sequences"].each do |s|
      s["canvases"].each do |c|
        if c.has_key?("otherContent")
          annotations = annotations + c["otherContent"].select {|item| item["@type"] == "sc:AnnotationList"}.map{|item| item['label'] = c["label"]; item}
        end
      end
    end
    annotations
  end

  def get_modsxml
    self.modsxml = nil
    url = self.mods_url
    return nil unless url
    uri = URI.parse(url)
    uri.scheme = "https"
    require 'open-uri'
    self.modsxml = open(uri.to_s).read
  end

end
