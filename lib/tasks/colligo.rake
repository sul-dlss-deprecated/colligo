require 'csv'
namespace :colligo do
  desc "index mods.xml and Annotations.json for each iiif manifest part of the collection"
  task :index_iiif_manifests, [:collection, :csv_file] => [:environment] do |t, args|
    raise "File #{args.csv_file} does not exist" unless File.exist?(args.csv_file)
    @conn = Blacklight.default_index.connection
    CSV.foreach(args.csv_file) do |row|
      # get url
      @url = row[0]
      # get iiif manifest
      @manifest = read_manifest
      # initialize solr document model
      @modsxml =  @manifest.get_modsxml
      @doc = SolrDocument.new(modsxml: @modsxml, druid: @manifest.druid, 
        collection: args.collection, iiif_manifest: @url, mods_url: @manifest.mods_url)
      # index mods xml
      index_mods
      # index annotations
      @annotation_lists = @manifest.annotation_lists
      index_annotations
    end
    @conn.commit
  end
end

def read_manifest
  @manifest = IiifManifest.new(@url)
  @manifest.read_manifest 
  return @manifest
end

def index_mods
  # index mods data in solr
  solr_doc = @doc.mods_to_solr
  @conn.add solr_doc
end

def index_annotations
  return unless @annotation_lists
  # array of hashes with key '@id', '@type', 'label'
  # method to index each annotation
  @annotation_lists.each do |al|
    annotation_list = @doc.read_annotation(al['@id'])
    if annotation_list.has_key("resources")
      annotation_list["resources"].each do |a|
        data = { "annotation" => a, "manuscript" => @doc.title, "folio" => al['label'], "url" => al['@id'] }
        solr_doc = @doc.annotation_to_solr(data)
        @conn.add solr_doc
      end
    end
  end
end

def commit
  @conn.commit
end
