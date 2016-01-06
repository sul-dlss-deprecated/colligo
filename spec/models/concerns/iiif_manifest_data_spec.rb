require 'spec_helper'

class IiifManifestDataTestClass
  include IiifManifestData
end

describe IiifManifestData do
  include IiifManifestFixtures
  before(:all) do
    @document_empty = IiifManifest.new
    @document_empty.read_manifest
    response1 = File.open("#{::Rails.root}/spec/fixtures/iiif_manifest_records/manifest_001.json").read
    stub_request(:get, manifest_url_001)
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: response1, headers: {})
    @document = IiifManifest.new(manifest_url_001)
    @document.read_manifest
    response2 = File.open("#{::Rails.root}/spec/fixtures/iiif_manifest_records/manifest_004.json").read
    stub_request(:get, manifest_url_004)
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: response2, headers: {})
    @document2 = IiifManifest.new(manifest_url_004)
    @document2.read_manifest
  end

  describe '#read_manifest' do
    it 'should be nil if no manifest url' do
      expect(@document_empty.manifest).to be_nil
    end

    it 'should be a Hash' do
      expect(@document.manifest).to be_a Hash
      expect(@document2.manifest).to be_a Hash
    end
    it 'should not be an empty Hash' do
      expect(@document.manifest).not_to be_empty
      expect(@document2.manifest).not_to be_empty
    end
  end
  describe '#title' do
    it 'should be nil if no manifest url' do
      expect(@document_empty.title).to be_nil
    end

    it 'should be a string' do
      expect(@document.title).to be_a String
      expect(@document2.title).to be_a String
    end

    it 'should be a title string' do
      expect(@document.title).to eq('Manuscript fragment of the Gospels and Canonical Epistles, glossed')
      expect(@document2.title).to eq('Stanford University Libraries, M1814. Flat Box 2, Folder 02')
    end
  end
  describe '#druid' do
    it 'should be nil if no manifest url' do
      expect(@document_empty.druid).to be_nil
    end

    it 'should be a string' do
      expect(@document.druid).to be_a String
      expect(@document2.druid).to be_a String
    end

    it 'should be a druid string' do
      expect(@document.druid).to eq('kq131cs7229')
      expect(@document2.druid).to eq('bb389yg4719')
    end
  end

  describe '#thumbnail' do
    it 'should be nil if no manifest url' do
      expect(@document_empty.thumbnail).to be_nil
    end

    it 'should be nil if no thumbnail' do
      expect(@document.thumbnail).to be_nil
    end

    it 'should be a string' do
      expect(@document2.thumbnail).to be_a String
    end

    it 'should be a url string' do
      expect(@document2.thumbnail).to eq('https://stacks.stanford.edu/image/iiif/bb389yg4719%2Fbb389yg4719_05_0001/full/!400,400/0/default.jpg')
    end
  end

  describe '#mods_url' do
    it 'should be nil if no manifest url' do
      expect(@document_empty.mods_url).to be_nil
    end

    it 'should be a string' do
      expect(@document.mods_url).to be_a String
      expect(@document2.mods_url).to be_a String
    end

    it 'should be a mods url string' do
      expect(@document.mods_url).to eq('http://purl.stanford.edu/kq131cs7229.mods')
      expect(@document2.mods_url).to eq('https://purl.stanford.edu/bb389yg4719.mods')
    end
  end

  describe '#annotation_lists' do
    it 'should be an array' do
      expect(@document_empty.annotation_lists).to be_a Array
      expect(@document.annotation_lists).to be_a Array
      expect(@document2.annotation_lists).to be_a Array
    end

    it 'should be an empty array if no manifest url' do
      expect(@document_empty.annotation_lists).to be_empty
      expect(@document2.annotation_lists).to be_empty
    end

    it 'should not be an empty array' do
      expect(@document.annotation_lists).not_to be_empty
    end
    it 'should be of length 36' do
      expect(@document.annotation_lists.length).to eq(36)
    end
    it 'should be an array of hashes' do
      expect(@document.annotation_lists.any? { |hash| hash.keys == %w(@id @type label) }).to be_true
    end
  end
  describe '#fetch_modsxml' do
    before do
      response_mods1 = File.open("#{::Rails.root}/spec/fixtures/iiif_manifest_records/mods_001.xml").read
      # Note mods_url converted to https by fetch
      stub_request(:get, 'https://purl.stanford.edu/kq131cs7229.mods')
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: response_mods1, headers: {})
      response_mods2 = File.open("#{::Rails.root}/spec/fixtures/iiif_manifest_records/mods_004.xml").read
      stub_request(:get, 'https://purl.stanford.edu/bb389yg4719.mods')
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: response_mods2, headers: {})
      @document_empty.fetch_modsxml
      @document.fetch_modsxml
      @document2.fetch_modsxml
    end
    it 'should be nil if no manifest url' do
      expect(@document_empty.title).to be_nil
    end

    it 'should be a String' do
      expect(@document.modsxml).to be_a String
      expect(@document2.modsxml).to be_a String
    end

    it 'should be a xml doc' do
      expect(@document.modsxml).to start_with('<?xml')
      expect(@document2.modsxml).to start_with('<?xml')
    end
  end
end
