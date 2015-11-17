require "spec_helper"

class AnnotationDataTestClass
  include AnnotationData
end

describe AnnotationData do
  include AnnotationFixtures
  #anno_str = File.read("fixtures/annotation_records/annotation-001.json")
  let(:document) { SolrDocument.new(annotationjson: annotation_001) }
  let(:anno1) { { 
    "@id" => "_:N43deaea09a5345379218db8cb72600c3",
    "@type" => "oa:Annotation",
    "motivation" => "sc:painting",
    "resource" => 
    {
        "@id" => "7377e5fe51c46454bb01b62a817a4d42",
        "@type" => "cnt:ContentAsText",
        "format" => "text/plain",
        "chars" => "Erant aut[em] qui manducaverant",
        "language" => "lat"
    },
    "on" => "http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/canvas/canvas-3#xywh=600,450,1017,166"
  } }

  describe "#annotation" do
    it "should be nil if no annotationjson" do
      expect(SolrDocument.new().annotation).to be_nil
    end

    it "should be a Hash" do
      expect(document.annotation).to be_a Hash
    end

    it "should have the keys @context, @id, @type and resources" do
      expect(document.annotation.keys).to eq(["@context", "@id", "@type", "resources"])
    end

    it "should have an array of resources" do
      expect(document.annotation["resources"]).to be_a Array
    end

    it "should have 19 annotations" do 
      expect(document.annotation["resources"].length).to eq 19
    end

    it "should have the first annotation equal anno1" do
      expect(document.annotation["resources"].first).to eq(anno1)
    end

  end

end
