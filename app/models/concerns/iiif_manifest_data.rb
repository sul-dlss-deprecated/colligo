module IiifManifestData
  include JsonReader
  extend ActiveSupport::Concern

  attr_accessor :manifest_url, :manifest, :modsxml

  def read_manifest
    return nil unless manifest_url
    self.manifest = JsonReader::Reader.new.from_url(manifest_url)
  end

  def title
    return nil unless manifest_url
    read_manifest unless manifest
    return nil unless manifest
    manifest['label']
  end

  def druid
    # druid is a 11 digit alphanumeric sring
    return nil unless manifest_url
    read_manifest unless manifest
    return nil unless manifest
    manifest['@id'].match(%r{/([a-zA-Z0-9]{11})/}).to_s.delete('/')
  end

  def mods_url
    return nil unless manifest_url
    read_manifest unless manifest
    return nil unless manifest
    return nil unless manifest.key?('seeAlso')
    if manifest['seeAlso']['dcterms:format'] == 'application/mods+xml'
      return manifest['seeAlso']['@id']
    elsif manifest['seeAlso']['format'] == 'application/mods+xml'
      return manifest['seeAlso']['@id']
    end
    nil
  end

  def annotation_lists
    return [] unless manifest_url
    read_manifest unless manifest
    return [] unless manifest
    annotations = []
    manifest['sequences'].each do |s|
      s['canvases'].each do |c|
        if c.key?('otherContent')
          annotations += c['otherContent'].select { |item| item['@type'] == 'sc:AnnotationList' }.map { |item| item['label'] = c['label']; item }
        end
      end
    end
    annotations
  end

  def fetch_modsxml
    self.modsxml = nil
    url = mods_url
    return nil unless url
    uri = URI.parse(url)
    uri.scheme = 'https'
    require 'open-uri'
    self.modsxml = open(uri.to_s).read
  end
end
