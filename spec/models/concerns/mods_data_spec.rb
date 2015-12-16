require "spec_helper"

class ModsDataTestClass
  include ModsData
end

describe ModsData do
  include ModsFixtures
  let(:document) { SolrDocument.new(modsxml: dms_mods_001) }
  let(:document_with_id) { SolrDocument.new(modsxml: dms_mods_001,
                                            druid: "fh878gz0315",
                                            collection: "Parker collection",
                                            iiif_manifest: "http://dms-data.stanford.edu/data/manifests/Parker/fh878gz0315/manifest.json",
                                            mods_url: "https://purl.stanford.edu/fh878gz0315.mods") }
  let(:document_with_id2) { SolrDocument.new(modsxml: dms_mods_005,
                                            druid: "kh686yw0435",
                                            collection: "Stanford University Libraries",
                                            iiif_manifest: "http://dms-data.stanford.edu/data/manifests/Parker/kh686yw0435/manifest.json",
                                            mods_url: "https://purl.stanford.edu/kh686yw0435.mods") }

  describe "#mods" do
    it "should be nil if no modsxml" do
      expect(SolrDocument.new().mods).to be_nil
    end

    it "should be a ModsDisplay" do
      expect(document.mods).to be_a ModsDisplay::HTML
      expect(document_with_id.mods).to be_a ModsDisplay::HTML
      expect(document_with_id2.mods).to be_a ModsDisplay::HTML
    end
  end

  describe "#mods_raw" do
    it "should be nil if no modsxml" do
      expect(SolrDocument.new().mods_raw).to be_nil
    end

    it "should be a ModsDisplay" do
      expect(document.mods_raw).to be_a Stanford::Mods::Record
      expect(document_with_id.mods_raw).to be_a Stanford::Mods::Record
      expect(document_with_id2.mods_raw).to be_a Stanford::Mods::Record
    end

    it "should have title" do
      expect(document.mods_raw.sort_title).to eq("Old English Homilies, mostly by Ælfric")
      expect(document_with_id.mods_raw.sort_title).to eq("Old English Homilies, mostly by Ælfric")
      expect(document_with_id2.mods_raw.sort_title).to eq("Fragment from a Beneventan Psalter")
    end

    it "should have alternative title" do
      expect(document.mods_raw.alternative_titles).to eq(["Homiliae Saxonicae (IV)"])
      expect(document_with_id.mods_raw.alternative_titles).to eq(["Homiliae Saxonicae (IV)"])
      expect(document_with_id2.mods_raw.alternative_titles).to eq(["Stanford University Libraries, M0389"])
    end
  end

  describe "#prettified_mods" do
    it "should be nil if no modsxml" do
      expect(SolrDocument.new().prettified_mods).to be_nil
    end

    it "should return prettified mods" do
      expect(document.prettified_mods).to be_a String
      expect(document.prettified_mods).to match /<div class="CodeRay">/
      expect(document.prettified_mods).to match />Old English Homilies, mostly by Ælfric</
    end
  end

  describe "#mods_to_solr" do
    let(:data) { document.mods_to_solr }
    let(:data_with_id) { document_with_id.mods_to_solr }
    let(:data_with_id2) { document_with_id2.mods_to_solr }
    it "should be a empty hash if no modsxml" do
      expect(SolrDocument.new().mods_to_solr).to eq({})
    end

    it "should return a Hash" do
      expect(data).to be_a Hash
      expect(data_with_id).to be_a Hash
      expect(data_with_id2).to be_a Hash
    end

    it "should be a empty hash if no id" do
      expect(data).to eq({})
    end

    it "should not be a empty hash with id" do
      expect(data_with_id).to_not eq({})
      expect(data_with_id2).to_not eq({})
    end

    it "should have an id" do
      expect(data_with_id).to have_key("id")
      expect(data_with_id["id"]).to eq("fh878gz0315")
      expect(data_with_id2["id"]).to eq("kh686yw0435")
    end

    it "should have an druid" do
      expect(data_with_id).to have_key("druid")
      expect(data_with_id["druid"]).to eq("fh878gz0315")
      expect(data_with_id2["druid"]).to eq("kh686yw0435")
    end

    it "should have a title" do
      expect(data_with_id).to have_key("title_search")
      expect(data_with_id["title_search"]).to eq("Old English Homilies, mostly by Ælfric")
      expect(data_with_id2["title_search"]).to eq("Fragment from a Beneventan Psalter")
    end

    it "should have a topic" do
      expect(data_with_id).to have_key("topic_search")
    end

    it "should belong to the parker collection" do
      expect(data_with_id).to have_key("collection")
      expect(data_with_id["collection"]).to eq("Parker collection")
    end

    it "should have manifest url" do
      expect(data_with_id).to have_key("manifest_urls")
      expect(data_with_id["manifest_urls"]).to eq("http://dms-data.stanford.edu/data/manifests/Parker/fh878gz0315/manifest.json")
    end

    it "should have url" do
      expect(data_with_id).to have_key("url_sfx")
      expect(data_with_id["url_sfx"]).to eq("https://purl.stanford.edu/fh878gz0315.mods")
    end

    it "should have model Manuscript" do
      expect(data_with_id).to have_key("model")
      expect(data_with_id["model"]).to eq("Manuscript")
    end
  end

  describe "#parse dates" do
    let(:dates1) { document.send(:parse_dates, nil) }
    let(:dates2) { document.send(:parse_dates, ["1389"]) }
    let(:dates3) { document.send(:parse_dates, ["850","1499"]) }
    let(:dates4) { document.send(:parse_dates, ["Ca. 1580 CE"]) }
    let(:dates5) { document.send(:parse_dates, ["1500 CE"]) }
    let(:dates6) { document.send(:parse_dates, ["14uu"]) }
    let(:dates7) { document.send(:parse_dates, ["February 6, 1486"]) }
    let(:dates8) { document.send(:parse_dates, ["June 1781"]) }
    let(:dates9) { document.send(:parse_dates, ["s. XIII^^ex [ca. 1275-1300]"]) }
    it "should be a hash" do
      expect(dates1).to be_a Hash
      expect(dates2).to be_a Hash
      expect(dates3).to be_a Hash
      expect(dates4).to be_a Hash
      expect(dates5).to be_a Hash
      expect(dates6).to be_a Hash
      expect(dates7).to be_a Hash
      expect(dates8).to be_a Hash
      expect(dates9).to be_a Hash
    end

    it "should have the keys all_int, sort" do
      expect(dates1.keys).to eq([:all_int, :sort])
      expect(dates2.keys).to eq([:all_int, :sort])
      expect(dates3.keys).to eq([:all_int, :sort])
      expect(dates4.keys).to eq([:all_int, :sort])
      expect(dates5.keys).to eq([:all_int, :sort])
      expect(dates6.keys).to eq([:all_int, :sort])
      expect(dates7.keys).to eq([:all_int, :sort])
      expect(dates8.keys).to eq([:all_int, :sort])
      expect(dates9.keys).to eq([:all_int, :sort])
    end

    it "should be an array for all_int" do
      expect(dates1[:all_int]).to be_a Array
      expect(dates2[:all_int]).to be_a Array
      expect(dates3[:all_int]).to be_a Array
      expect(dates4[:all_int]).to be_a Array
      expect(dates5[:all_int]).to be_a Array
      expect(dates6[:all_int]).to be_a Array
      expect(dates7[:all_int]).to be_a Array
      expect(dates8[:all_int]).to be_a Array
      expect(dates9[:all_int]).to be_a Array
    end

    it "should be an array of all integer dates" do
      expect(dates1[:all_int]).to be_empty
      expect(dates2[:all_int]).to eq([1389])
      expect(dates3[:all_int]).to eq([850, 1499])
      expect(dates4[:all_int]).to eq([1580])
      expect(dates5[:all_int]).to eq([1500])
      expect(dates6[:all_int]).to eq([1400, 1499])
      expect(dates7[:all_int]).to eq([1486])
      expect(dates8[:all_int]).to eq([1781])
      expect(dates9[:all_int]).to eq([1275, 1300])
    end

    it "should be an integer year for sort" do
      expect(dates1[:sort]).to be_empty
      expect(dates2[:sort]).to be_a Integer
      expect(dates3[:sort]).to be_a Integer
      expect(dates4[:sort]).to be_a Integer
      expect(dates5[:sort]).to be_a Integer
      expect(dates6[:sort]).to be_a Integer
      expect(dates7[:sort]).to be_a Integer
      expect(dates8[:sort]).to be_a Integer
      expect(dates9[:sort]).to be_a Integer
    end

    it "should be the average integer year for sort" do
      expect(dates1[:sort]).to be_empty
      expect(dates2[:sort]).to eq(1389)
      expect(dates3[:sort]).to eq(1174)
      expect(dates4[:sort]).to eq(1580)
      expect(dates5[:sort]).to eq(1500)
      expect(dates6[:sort]).to eq(1449)
      expect(dates7[:sort]).to eq(1486)
      expect(dates8[:sort]).to eq(1781)
      expect(dates9[:sort]).to eq(1287)
    end
  end
end
