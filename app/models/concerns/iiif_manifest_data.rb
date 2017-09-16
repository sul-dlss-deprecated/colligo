# Module to read the IIIF manifest and extract particular content
module IiifManifestData
  include JsonReader
  extend ActiveSupport::Concern

  attr_accessor :manifest_url, :manifest, :modsxml

  # Read the manifest from the given url
  def read_manifest
    return nil unless manifest_url
    self.manifest = JsonReader::Reader.new.from_url(manifest_url)
  end

  # Get the title/label from the manifest
  def title
    return nil unless manifest_url
    read_manifest unless manifest
    return nil unless manifest
    manifest['label']
  end
  
  # Get the description from the manifest
  def description
    return nil unless manifest_url
    read_manifest unless manifest
    return nil unless manifest
    manifest['description']
  end
  
  # Get the license from the manifest
  def license
    return nil unless manifest_url
    read_manifest unless manifest
    return nil unless manifest
    manifest['license']
  end
  
  # Get the attribution from the manifest
  def attribution
    return nil unless manifest_url
    read_manifest unless manifest
    return nil unless manifest
    manifest['attribution']
  end

  # Get the pid from the manifest
  def druid
    # druid is a 11 digit alphanumeric sring
    return nil unless manifest_url
    read_manifest unless manifest
    return nil unless manifest
    manifest['@id'].match(%r{/([a-zA-Z0-9]{11})/}).to_s.delete('/')
  end

  # Get the thumbnail for the resources described by the manifest
  def thumbnail
    return nil unless manifest_url
    read_manifest unless manifest
    return nil unless manifest
    #return nil unless manifest.key?('thumbnail')
    if manifest.key?('thumbnail')
      thumbnail =  manifest['thumbnail']['@id']
    else
      sequence = manifest['sequences'].first
      canvas = sequence['canvases'].first
      i = canvas['images'].first
      res = i['resource']
      #thumbnail = res['@id']+"/full/!400,400/0/default.jpg"
      thumbnail = sequence
    return thumbnail
  end
  end


  # Get the url for the mods metadata listed in the see also in the manifest
  def mods_url
    return nil unless manifest_url
    read_manifest unless manifest
    return nil unless manifest
    return nil unless manifest.key?('seeAlso')
    if manifest['seeAlso']['dcterms:format'] == 'application/mods+xml' ||
       manifest['seeAlso']['format'] == 'application/mods+xml'
      return manifest['seeAlso']['@id']
    end
    nil
  end

  # Get the list of open annotation reources listed in the manifest
  # for each cnavas along with the img resource
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
            if i.key?('resource') && i['resource'].key?('@id') && i['resource']['@id'] &&
               i['resource'].key?('format') && %w(image/jpeg image/png).include?(i['resource']['format'])
              img_info << i['resource']['@id']
            end
          end
        end
        next unless c.key?('otherContent')
        annotations += c['otherContent'].select { |item| item['@type'] == 'sc:AnnotationList' }.map do |item|
          item['label'] = c['label']
          item['img_info'] = img_info
          item
        end
      end
    end
    annotations
  end

  # Get a list of all the canvases described in the manifest along with their metadata
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

  # Extract the contents of the mods-xml pointed to by the mods_url in the manifest
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
