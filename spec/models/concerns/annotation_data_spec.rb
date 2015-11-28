require "spec_helper"

class AnnotationDataTestClass
  include AnnotationData
end

describe AnnotationData do
  include AnnotationFixtures
  let(:document) { SolrDocument.new() }
  let(:annotation_list) { document.read_annotation(annotation_url_001) }
  let(:document_with_id) { SolrDocument.new(druid: "kq131cs7229", 
                                            collection: "Parker collection", 
                                            iiif_manifest: "http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/manifest.json", 
                                            mods_url: "https://purl.stanford.edu/kq131cs7229.mods") }

  describe "#read_annotation" do
    it "should be nil if no annotation url" do
      expect(SolrDocument.new().read_annotation()).to be_nil
    end

    it "should be a Hash" do
      expect(annotation_list).to be_a Hash
    end

    it "should have the keys @context, @id, @type and resources" do
      expect(annotation_list.keys).to eq(["@context", "@id", "@type", "resources"])
    end

    it "should have an array of resources" do
      expect(annotation_list["resources"]).to be_a Array
    end

    it "should have 19 annotations" do 
      expect(annotation_list["resources"].length).to eq 19
    end

    it "should have the first annotation equal annotation_001" do
      expect(annotation_list["resources"].first).to eq(annotation_001)
    end
  end

  describe "#annotations" do
    it "should be an Array" do
      expect(document.annotations(annotation_list)).to be_a Array
      expect(SolrDocument.new().annotations()).to be_a Array
    end

    it "should be empty if no annotation url" do
      expect(SolrDocument.new().annotations()).to be_empty
    end

    it "should have no annotations" do 
      expect(document.annotations(annotation_list).length).to eq 0
    end
  end

  describe "#transcriptions" do
    it "should be an Array" do
      expect(document.transcriptions(annotation_list)).to be_a Array
      expect(SolrDocument.new().transcriptions()).to be_a Array
    end

    it "should be empty if no annotation url" do
      expect(SolrDocument.new().transcriptions()).to be_empty
    end

    it "should have 19 transcriptions" do 
      expect(document.transcriptions(annotation_list).length).to eq 19
    end

    it "should have the first transcription equal annotation_001" do
      expect(document.transcriptions(annotation_list).first).to eq(annotation_001)
    end
  end

  describe "#map_annotation" do
    it "should be an Hash" do
      expect(document.map_annotation(annotation_001)).to be_a Hash
      expect(SolrDocument.new().map_annotation()).to be_a Hash
    end

    it "should be empty if no annotation url" do
      expect(SolrDocument.new().map_annotation()).to be_empty
    end

    it "should be empty if no annotation url" do
      expect(document.map_annotation(annotation_001)).not_to be_empty
    end

    it "should have the keys id, motivation, target_type, target_url, body_type, body_format, body_chars and body_language" do
      expect(document.map_annotation(annotation_001).keys).to eq(['id', 'target_type', 'motivation', 'target_url', 'body_type', 'body_format', 'body_chars', 'body_language'])
    end
  end

  describe "#annotation_to_solr" do
    let(:solr_doc_all) { document_with_id.annotation_to_solr(solr_data_all) }
    let(:solr_doc_no_id) { document.annotation_to_solr(solr_data_no_id) }
    let(:solr_doc_no_anno) { document.annotation_to_solr(solr_data_no_anno) }

    it "should be a empty hash if no annotation url" do
      expect(SolrDocument.new().annotation_to_solr).to eq({})
    end

    it "should return a Hash" do
      expect(solr_doc_all).to be_a Hash
      expect(solr_doc_no_id).to be_a Hash
      expect(solr_doc_no_anno).to be_a Hash
    end

    it "should be a empty hash if no annotation data" do
      expect(solr_doc_no_anno).to eq({})
    end

    it "should be a empty hash if no id" do
      expect(solr_doc_no_id).to eq({})
    end

    it "should not be a empty hash with id" do
      expect(solr_doc_all).to_not eq({})
    end

    it "should have an id" do
      expect(solr_doc_all).to have_key("id")
      expect(solr_doc_all["id"]).to eq("_:N43deaea09a5345379218db8cb72600c3")
    end

    it "should have an druid" do
      expect(solr_doc_all).to have_key("druid")
      expect(solr_doc_all["druid"]).to eq("kq131cs7229")
    end

    it "should have a body chars" do
      expect(solr_doc_all).to have_key("body_chars_search")
      expect(solr_doc_all["body_chars_search"]).to eq("Erant aut[em] qui manducaverant")
    end

    it "should belong to the parker collection" do
      expect(solr_doc_all).to have_key("collection")
      expect(solr_doc_all["collection"]).to eq("Parker collection")
    end

    it "should have manifest url" do
      expect(solr_doc_all).to have_key("manifest_urls")
      expect(solr_doc_all["manifest_urls"]).to eq("http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/manifest.json")
    end

    it "should have url" do
      expect(solr_doc_all).to have_key("url_sfx")
      expect(solr_doc_all["url_sfx"]).to eq("http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/list/text-f8r.json")
    end

    it "should have folio" do
      expect(solr_doc_all).to have_key("folio")
      expect(solr_doc_all["folio"]).to eq("f. 8r")
    end
  end
end
