require "spec_helper"

class AnnotationDataReaderTestClass
  include AnnotationData
end

describe AnnotationData::Reader do
  include AnnotationFixtures
  before(:all) do
    @example_str = annotation_001
    @example_url = 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/list/text-f8r.json'
    @fixture_dir =  Rails.root.join "spec/fixtures"
    @fixture_annotation_file = File.join(@fixture_dir, 'annotation_records/annotation-001.json')
    @doc_from_str = AnnotationData::Reader.new.from_str(@example_str)
    @doc_from_url = AnnotationData::Reader.new.from_url(@example_url)
    @doc_from_file = AnnotationData::Reader.new.from_file(@fixture_annotation_file)
  end
   
  context "from_str" do
    it "from_str should turn a json string into a Hash" do
      expect(@doc_from_str).to be_a Hash
    end
    it "should have the keys @context, @id, @type and resources" do
      expect(@doc_from_str.keys).to eq(["@context", "@id", "@type", "resources"])
    end
    it "should have an array of resources" do
      expect(@doc_from_str["resources"]).to be_a Array
    end
  end

  context "from_url" do
    it "from_url should turn the contents at the url into a Hash" do
      expect(@doc_from_url).to be_a Hash
    end
    it "should have the keys @context, @id, @type and resources" do
      expect(@doc_from_url.keys).to eq(["@context", "@id", "@type", "resources"])
    end
    it "should have an array of resources" do
      expect(@doc_from_url["resources"]).to be_a Array
    end
  end

  context "from_file" do
    it "should turn the contents of a file into a Hash" do
      expect(@doc_from_file).to be_a Hash
    end
    it "should give a meaningful error if passed a bad file" do
      expect(lambda{AnnotationData::Record.new.from_file('/fake/file')}).to raise_error
    end
    it "should have the keys @context, @id, @type and resources" do
      expect(@doc_from_file.keys).to eq(["@context", "@id", "@type", "resources"])
    end
    it "should have an array of resources" do
      expect(@doc_from_file["resources"]).to be_a Array
    end
  end

end
