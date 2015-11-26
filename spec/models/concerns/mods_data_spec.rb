require "spec_helper"

class ModsDataTestClass
  include ModsData
end

describe ModsData do
  include ModsFixtures
  let(:document) { SolrDocument.new(modsxml: dms_mods_001) }

  describe "#mods" do
    it "should be nil if no modsxml" do
      expect(SolrDocument.new().mods).to be_nil
    end

    it "should be a ModsDisplay" do
      expect(document.mods).to be_a ModsDisplay::HTML
    end
  end
  
  describe "#mods_raw" do
    it "should be nil if no modsxml" do
      expect(SolrDocument.new().mods_raw).to be_nil
    end

    it "should be a ModsDisplay" do
      expect(document.mods_raw).to be_a Stanford::Mods::Record
    end
    
    it "should have title" do
      expect(document.mods_raw.sort_title).to eq("Old English Homilies, mostly by Ælfric")
    end
    
    it "should have alternative title" do
      expect(document.mods_raw.alternative_titles).to eq(["Homiliae Saxonicae (IV)"])
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
end
