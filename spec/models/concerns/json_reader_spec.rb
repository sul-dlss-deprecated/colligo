require 'rails_helper'

class JsonReaderTestClass
  include JsonReader
end

describe JsonReader::Reader do
  include AnnotationFixtures
  before(:all) do
    @fixture_dir = Rails.root.join 'spec/fixtures'
    @example_url = 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/list/text-f8r.json'
    @example_bad_url = 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/list/text.json'
  end

  context 'from_str' do
    before do
      @example_str = annotation_list_001
      @doc_from_str = JsonReader::Reader.new.from_str(@example_str)
    end
    it 'from_str should turn a json string into a Hash' do
      expect(@doc_from_str).to be_a Hash
    end
    it 'should have the keys @context, @id, @type and resources' do
      expect(@doc_from_str.keys).to eq(%w(@context @id @type resources))
    end
    it 'should have an array of resources' do
      expect(@doc_from_str['resources']).to be_a Array
    end
  end

  context 'from_url' do
    before do
      stub_request(:get, @example_url)
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: File.open("#{::Rails.root}/spec/fixtures/annotation_records/annotation_001.json").read, headers: {})
      @doc_from_url = JsonReader::Reader.new.from_url(@example_url)
      stub_request(:get, @example_bad_url)
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: [404, 'File not found'])
      @doc_from_bad_url = JsonReader::Reader.new.from_url(@example_bad_url)
    end
    it 'should return nil if url is bad' do
      expect(@doc_from_bad_url).to be_nil
    end
    it 'should turn the contents at the url into a Hash' do
      expect(@doc_from_url).to be_a Hash
    end
    it 'should have the keys @context, @id, @type and resources' do
      expect(@doc_from_url.keys).to eq(%w(@context @id @type resources))
    end
    it 'should have an array of resources' do
      expect(@doc_from_url['resources']).to be_a Array
    end
  end

  context 'from_file' do
    before do
      @fixture_annotation_file = File.join(@fixture_dir, 'annotation_records/annotation_001.json')
      @doc_from_file = JsonReader::Reader.new.from_file(@fixture_annotation_file)
    end
    it 'should turn the contents of a file into a Hash' do
      expect(@doc_from_file).to be_a Hash
    end
    it 'should give a meaningful error if passed a bad file' do
      expect(-> { JsonReader::Record.new.from_file('/fake/file') }).to raise_error
    end
    it 'should have the keys @context, @id, @type and resources' do
      expect(@doc_from_file.keys).to eq(%w(@context @id @type resources))
    end
    it 'should have an array of resources' do
      expect(@doc_from_file['resources']).to be_a Array
    end
  end
end
