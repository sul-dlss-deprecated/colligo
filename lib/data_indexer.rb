require 'csv'
class DataIndexer
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
    if !@csv_file.blank? && File.exist?(@csv_file)
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
    return if @csv_file.blank? || !File.exist?(@csv_file)
    CSV.foreach(@csv_file) do |row|
      @url = row[0]
      index
    end
  end

  # Index MODS and annotation lists fetched from the IIIF manifest url
  def index
    fetch_manifest
    if define_doc
      index_mods
      index_annotations
    end
  end

  # Commit the data indexed in solr
  def commit
    @solr.commit
  end

  protected

  # Get the manifest data
  def fetch_manifest
    @manifest = IiifManifest.new(@url)
    @manifest.read_manifest
  end

  def define_doc
    unless @manifest.title.blank? || @manifest.druid.blank?
      @doc[:collection] = @collection
      @doc[:druid] = @manifest.druid
      @doc[:iiif_manifest] = @url
      @doc[:mods_url] = @manifest.mods_url
      @doc[:thumbnail] = @manifest.thumbnail
      @doc[:modsxml] = @manifest.fetch_modsxml
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

  # index all of the annotations data in solr
  def index_annotations
    list_count = 0
    doc_count = 0
    add_count = 0
    @manifest.annotation_lists.each do |al|
      annotation_list = @doc.read_annotation(al['@id'])
      @doc.resources(annotation_list).each do |a|
        data = { 'annotation' => a, 'manuscript' => @title, 'folio' => al['label'], 'url' => al['@id'] }
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
