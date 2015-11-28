require "spec_helper"

class IiifManifestDataTestClass
  include IiifManifestData
end

describe IiifManifestData do
  include IiifManifestFixtures
  before(:all) do
    @document_empty = IiifManifest.new()
    @document_empty.read_manifest
    @document = IiifManifest.new(manifest_url=manifest_url_001)
    @document.read_manifest
  end

  describe "#read_manifest" do
    it "should be nil if no manifest url" do
      expect(@document_empty.manifest).to be_nil
    end

    it "should be a Hash" do
      expect(@document.manifest).to be_a Hash
    end
    
    it "should not be an empty Hash" do
      expect(@document.manifest).not_to be_empty
    end
  end
  
  describe "#title" do
    it "should be nil if no manifest url" do
      expect(@document_empty.title).to be_nil
    end

    it "should be a string" do
      expect(@document.title).to be_a String
    end

    it "should be a title string" do
      expect(@document.title).to eq("Manuscript fragment of the Gospels and Canonical Epistles, glossed")
    end
  end
  
  describe "#druid" do
    it "should be nil if no manifest url" do
      expect(@document_empty.druid).to be_nil
    end

    it "should be a string" do
      expect(@document.druid).to be_a String
    end

    it "should be a druid string" do
      expect(@document.druid).to eq("kq131cs7229")
    end
  end
  
  describe "#mods_url" do
    it "should be nil if no manifest url" do
      expect(@document_empty.mods_url).to be_nil
    end
    
    it "should be a string" do
      expect(@document.mods_url).to be_a String
    end

    it "should be a mods url string" do
      expect(@document.mods_url).to eq("http://purl.stanford.edu/kq131cs7229.mods")
    end
  end
  
  describe "#annotation_lists" do
    it "should be an array" do
      expect(@document_empty.annotation_lists).to be_a Array
      expect(@document.annotation_lists).to be_a Array
    end

    it "should be an empty array if no manifest url" do
      expect(@document_empty.annotation_lists).to be_empty
    end

    it "should not be an empty array" do
      expect(@document.annotation_lists).not_to be_empty
    end
    
    it "should be of length 36" do
      expect(@document.annotation_lists.length).to eq(36)
    end
    
    it "should be an array of hashes" do
      expect(@document.annotation_lists.any? {|hash| hash.keys == ['@id', '@type', 'label']}).to be_true
    end
  end
  
  describe "#get_modsxml" do
    before(:all) do
      @document.get_modsxml
    end
      
    it "should be nil if no manifest url" do
      expect(@document_empty.title).to be_nil
    end

    it "should be a Hash" do
      expect(@document.modsxml).to be_a String
      expect(@document.modsxml).to start_with ("<?xml")
    end
  end

end
