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

  def thumbnail
    return nil unless manifest_url
    read_manifest unless manifest
    return nil unless manifest
    return nil unless manifest.key?('thumbnail')
    manifest['thumbnail']['@id']
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
        img_info = []
        if c.key?('images')
          c['images'].each do |i|
            if i.key?('resource') and i['resource'].key?('@id') and i['resource']['@id'] and
                i['resource'].key?('format') and %w(image/jpeg image/png).include?(i['resource']['format'])
              img_info << i['resource']['@id']
            end
          end
        end
        if c.key?('otherContent')
          annotations += c['otherContent'].select { |item| item['@type'] == 'sc:AnnotationList' }.map do |item|
            item['label'] = c['label']
            item['img_info'] = img_info
            item
          end
        end
      end
    end
    annotations
  end

  def contents
    return [] unless manifest_url
    read_manifest unless manifest
    return [] unless manifest
    content_list = []
    manifest['sequences'].each do |s|
      s['canvases'].each do |c|
        data = { '@id' => c['@id'] }
        data['label'] = c['label'] if c.key?('label')
        if c.key?('images') && !c['images'].blank?
          c_img = c['images'].first
          data['motivation'] = c_img['motivation'] if c_img.key?('motivation')
          data['@type'] = c_img['@type'] if c_img.key?('@type')
          data['img'] = c_img['resource']['@id'] if c_img.key?('resource') && c_img['resource'].key?('@id')
        end
        content_list << data
      end
    end
    content_list
  end

  def fetch_modsxml
    self.modsxml = nil
    url = mods_url
    return nil unless url
    uri = URI.parse(url)
    uri.scheme = 'https'
    require 'open-uri'
    begin
      self.modsxml = open(uri.to_s).read
    rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, Errno::ETIMEDOUT, EOFError, SocketError,
           Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError, OpenURI::HTTPError => the_error
      puts "\nOpen URI error for #{uri}\n\t#{the_error.message}" # TODO: Add to log
      return nil
    end
  end
end
