require 'csv'
require 'net/http'

class VaticanDataIndexer
  # Index mods and annotations data from a list of manifest urls or each url
  # Params:
  # +collection+:: Name of collection the manifest(s) belong to
  # +csv_file+:: string containing the path to the csv file.
  #    File to have one url per line and no header
  # +manifest_url+:: url to the mnaifest file
  # Usage:
  #   DataIndexer.new('collection_name', 'file_path').run
  #      to index csv file
  #   DataIndexer.new('collection_name', nil, 'url').run
  #      to index one manifest at url
  def initialize(collection = nil, csv_file = nil, manifest_url = nil)
    @collection = collection
    @csv_file = csv_file
    @url = manifest_url
    @manifest = nil
    @title = nil
    @doc = SolrDocument.new
    @solr = Blacklight.default_index.connection
  end

  # Index and commit mods and annotations data either
  # from a list of manifest urls or each url
  # depending on the options
  def run
    if @csv_file.present? && File.exist?(@csv_file)
      index_csv
      commit
    elsif @url
      index
      commit
    end
  end

  # Index mods and annotations data from a list of manifest urls
  #   csv file to contain one url per line and no header
  def index_csv
    return unless @csv_file.present? && File.exist?(@csv_file)
    CSV.foreach(@csv_file) do |row|
      @url = row[0]
      index
    end
  end

  # Index MODS and annotation lists fetched from the IIIF manifest url
  def index
    return unless @url.present?
    fetch_manifest
    index_manifest if define_doc
  end

  # Commit the data indexed in solr
  def commit
    @solr.commit
  end

  protected

  # Get the manifest data
  def fetch_manifest
    @manifest = JSON.parse(open(@url).read)
  rescue OpenURI::HTTPError => e
    puts "URL: #{@url} returned #{e}"
  rescue JSON::ParserError => j
    puts "URL: #{@url} returned JSON error #{j}"
  end

  def define_doc
    unless @manifest['label'].blank?
      @doc[:collection] = @collection
      @doc[:iiif_manifest] = @url
      @doc[:thumbnail] = @manifest['thumbnail']
      return true
    end
    false
  end

  # index mods data in solr
  def index_mods
    solr_doc = @doc.mods_to_solr
    unless solr_doc.blank?
      @title = solr_doc['title_search'] if solr_doc.key?('title_search')
      @solr.add solr_doc
    end
  end

  # index manifest data in solr
  def index_manifest
    solr_doc = @doc.iiif_to_solr(@manifest, @collection)
    unless solr_doc.blank?
      @title = solr_doc['title_search'] if solr_doc.key?('title_search')
      @solr.add solr_doc
    end
  end

  # index all of the annotations data in solr
  def index_annotations
    list_count = 0
    doc_count = 0
    add_count = 0
    @manifest.annotation_lists.each do |al|
      annotation_list = @doc.read_annotation(al['@id'])
      @doc.resources(annotation_list).each.with_index(1) do |a, index|
        data = {
          'annotation' => a,
          'manuscript' => @title,
          'folio' => al['label'],
          'img_info' => al['img_info'],
          'url' => al['@id'],
          'sort_index' => index
        }
        solr_doc = @doc.annotation_to_solr(data)
        unless solr_doc.blank?
          @solr.add solr_doc
          add_count += 1
        end
        doc_count += 1
      end
      list_count += 1
    end
    [list_count, doc_count, add_count]
  end
end
