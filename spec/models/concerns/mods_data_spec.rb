require "spec_helper"

class ModsDataTestClass
  include ModsData
end

describe ModsData do
  include ModsFixtures
  let(:document) { SolrDocument.new(modsxml: dms_mods_001) }
  let(:document_with_id) { SolrDocument.new(modsxml: dms_mods_001, id: "absdefg") }

  describe "#mods" do
    it "should be nil if no modsxml" do
      expect(SolrDocument.new().mods).to be_nil
    end

    it "should be a ModsDisplay" do
      expect(document.mods).to be_a ModsDisplay::HTML
      expect(document_with_id.mods).to be_a ModsDisplay::HTML
    end
  end

  describe "#mods_raw" do
    it "should be nil if no modsxml" do
      expect(SolrDocument.new().mods_raw).to be_nil
    end

    it "should be a ModsDisplay" do
      expect(document.mods_raw).to be_a Stanford::Mods::Record
      expect(document_with_id.mods_raw).to be_a Stanford::Mods::Record
    end

    it "should have title" do
      expect(document.mods_raw.sort_title).to eq("Old English Homilies, mostly by Ælfric")
      expect(document_with_id.mods_raw.sort_title).to eq("Old English Homilies, mostly by Ælfric")
    end

    it "should have alternative title" do
      expect(document.mods_raw.alternative_titles).to eq(["Homiliae Saxonicae (IV)"])
      expect(document_with_id.mods_raw.alternative_titles).to eq(["Homiliae Saxonicae (IV)"])
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
    it "should be a empty hash if no modsxml" do
      expect(SolrDocument.new().mods_to_solr).to eq({})
    end

    it "should return a Hash" do
      expect(data).to be_a Hash
      expect(data_with_id).to be_a Hash
    end

    it "should be a empty hash if no id" do
      expect(data).to eq({})
    end

    it "should not be a empty hash with id" do
      expect(data_with_id).to_not eq({})
    end

    it "should have a title" do
      expect(data_with_id).to have_key("title_search")
      #expect(data["title_search"]).to eq("Old English Homilies, mostly by Ælfric")
    end
    it "should have a topic" do
      expect(data_with_id).to have_key("topic_search")
    end
  end
end
