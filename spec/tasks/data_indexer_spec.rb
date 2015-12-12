require 'spec_helper'
require 'data_indexer'

describe 'DataIndexer' do
  include IiifManifestFixtures
  # WebMock.disable_net_connect!(:allow => [/127.0.0.1/, /localhost/] )
  before(:all) do
    @stub_solr = Blacklight.default_index.connection
    # @stub_solr = double('solr')
    # expect(@stub_solr).to receive(:solr).at_least(1).times.and_return(@stub_solr)
  end
  before(:each) do
    @response = File.open("#{::Rails.root}/spec/fixtures/iiif_manifest_records/manifest_001_stub.json").read
    stub_request(:get, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/stub/manifest.json')
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: @response, headers: {})
    @response2 = File.open("#{::Rails.root}/spec/fixtures/mods_records/kq131cs7229.mods.xml").read
    stub_request(:get, 'https://purl.stanford.edu/kq131cs7229.mods')
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: @response2, headers: {})
    @response3 = File.open("#{::Rails.root}/spec/fixtures/annotation_records/kq131cs7229_list_text-f8r.json").read
    stub_request(:get, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/list/text-f8r.json')
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: @response3, headers: {})
    @response4 = File.open("#{::Rails.root}/spec/fixtures/annotation_records/kq131cs7229_list_text-f104v.json").read
    stub_request(:get, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/list/text-f104v.json')
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: @response4, headers: {})
    @response5 = File.open("#{::Rails.root}/spec/fixtures/iiif_manifest_records/manifest_002_stub.json").read
    stub_request(:get, 'http://dms-data.stanford.edu/data/manifests/BnF/jr903ng8662/stub/manifest.json')
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: @response5, headers: {})
    @response6 = File.open("#{::Rails.root}/spec/fixtures/mods_records/jr903ng8662.mods.xml").read
    stub_request(:get, 'https://purl.stanford.edu/jr903ng8662.mods')
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: @response6, headers: {})
    @response7 = File.open("#{::Rails.root}/spec/fixtures/annotation_records/jr903ng8662_list_text-Ar.json").read
    stub_request(:get, 'http://dms-data.stanford.edu/data/manifests/BnF/jr903ng8662/list/text-Ar.json')
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: @response7, headers: {})
    @response8 = File.open("#{::Rails.root}/spec/fixtures/annotation_records/jr903ng8662_list_text-Av.json").read
    stub_request(:get, 'http://dms-data.stanford.edu/data/manifests/BnF/jr903ng8662/list/text-Av.json')
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: @response8, headers: {})
  end

  describe '#new' do
    before do
      @di = DataIndexer.new('test collection', 'csv_file_path', 'manifest_url')
    end
    it 'should set the solr client' do
      expect(@di.instance_variable_get('@solr')).to eq(@stub_solr)
    end
    it 'should set the collection' do
      expect(@di.instance_variable_get('@collection')).to eq('test collection')
    end
    it 'should set the csv file' do
      expect(@di.instance_variable_get('@csv_file')).to eq('csv_file_path')
    end
    it 'should set the manifest url' do
      expect(@di.instance_variable_get('@url')).to eq('manifest_url')
    end
    it 'should set the title' do
      expect(@di.instance_variable_get('@title')).to be_nil
    end
    it 'should set the solr document' do
      expect(@di.instance_variable_get('@doc')).to be_a(SolrDocument)
    end
    it 'should set the solr client' do
      expect(@di.instance_variable_get('@collection')).to eq('test collection')
    end
  end

  describe '#fecth_manifest' do
    before do
      @di = DataIndexer.new('test collection', nil, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/stub/manifest.json')
      @di.send(:fetch_manifest)
    end
    it 'should have a manifest' do
      expect(@di.instance_variable_get('@manifest').manifest).to be_a(Hash)
      # expect(@di.instance_variable_get('@manifest').manifest).to eq(JSON.parse(@response))
    end
    it 'should have a title' do
      expect(@di.instance_variable_get('@manifest').title).to eq('Manuscript fragment of the Gospels and Canonical Epistles, glossed')
    end
    it 'should have a druid' do
      expect(@di.instance_variable_get('@manifest').druid).to eq('kq131cs7229')
    end
    it 'should have a mods_url' do
      expect(@di.instance_variable_get('@manifest').mods_url).to eq('http://purl.stanford.edu/kq131cs7229.mods')
    end
    it 'should have annotation lists' do
      expect(@di.instance_variable_get('@manifest').annotation_lists).to be_a(Array)
      expect(@di.instance_variable_get('@manifest').annotation_lists.length).to eq(2)
    end
  end

  describe '#define_doc' do
    before do
      @di = DataIndexer.new('test collection', nil, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/stub/manifest.json')
      @di.send(:fetch_manifest)
      @di.send(:define_doc)
    end
    it 'should have a collection' do
      expect(@di.instance_variable_get('@doc')[:collection]).to eq('test collection')
    end
    it 'should have a druid' do
      expect(@di.instance_variable_get('@doc')[:druid]).to eq('kq131cs7229')
    end
    it 'should have a manifest url' do
      expect(@di.instance_variable_get('@doc')[:iiif_manifest]).to eq('http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/stub/manifest.json')
    end
    it 'should have a mods url' do
      expect(@di.instance_variable_get('@doc')[:mods_url]).to eq('http://purl.stanford.edu/kq131cs7229.mods')
    end
    it 'should have a thumbnail' do
      expect(@di.instance_variable_get('@doc')[:thumbnail]).to eq('https://stacks.stanford.edu/image/iiif/kq131cs7229%2Fsulmss_misc305_008r_SM/full/!400,400/0/default.jpg')
    end
    it 'should have a mods xml' do
      expect(@di.instance_variable_get('@doc')[:modsxml]).to eq(@response2)
    end
  end

  describe '#index_mods' do
    before do
      @di = DataIndexer.new('test collection', nil, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/stub/manifest.json')
      @di.send(:fetch_manifest)
      @di.send(:define_doc)
      # @di.send(:index_mods) #TODO: connection is being refused by solr
    end
    it 'is a pending test'
    # it 'should have received an add' do
    #   expect(@stub_solr).to receive(:solr).at_least(1).times.and_return(@stub_solr) #TODO: How do I test solr received an add
    # end
  end

  describe '#index_annotations' do
    before do
      @di = DataIndexer.new('test collection', nil, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/stub/manifest.json')
      @di.send(:fetch_manifest)
      @di.send(:define_doc)
      # @di.send(:index_mods) #TODO: connection is being refused by solr
      # @ans = @di.send(:index_annotations) #TODO: connection is being refused by solr
    end
    it 'is a pending test'
    # it 'should have received 3 adds' do
    #   expect(@stub_solr).to receive(:solr).at_least(44).times.and_return(@stub_solr) #TODO: How do I test solr received 44 adds (1  + 19 + 1 + 23)
    # end
    # it 'should have counted 2 lists do'
    #   expect(@ans[0]).to eq(2)
    # end
    # it 'should have counted 44 resources do'
    #   expect(@ans[1]).to eq(44)
    #   expect(@ans[2]).to eq(44)
    # end
  end

  describe '#index' do
    before do
      @di = DataIndexer.new('test collection', nil, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/stub/manifest.json')
      # @di.index #TODO: connection is being refused by solr
    end
    it 'is a pending test'
    # it 'should have received 3 adds' do
    #   expect(@stub_solr).to receive(:solr).at_least(44).times.and_return(@stub_solr) #TODO: How do I test solr received 44 adds (1  + 19 + 1 + 23)
    # end
    # it 'should have counted 2 lists do'
    #   expect(@ans[0]).to eq(2)
    # end
    # it 'should have counted 44 resources do'
    #   expect(@ans[1]).to eq(44)
    #   expect(@ans[2]).to eq(44)
    # end
  end

  describe '#index_csv' do
    before do
      @di = DataIndexer.new('test collection', manifest_csv_file, nil)
      # @di.index_csv #TODO: connection is being refused by solr
    end
    it 'is a pending test'
    # it 'should have received 3 adds' do
    #   expect(@stub_solr).to receive(:solr).at_least(44).times.and_return(@stub_solr) #TODO: How do I test solr received 44 adds (1  + 19 + 1 + 23)
    # end
    # it 'should have counted 2 lists do'
    #   expect(@ans[0]).to eq(2)
    # end
    # it 'should have counted 44 resources do'
    #   expect(@ans[1]).to eq(44)
    #   expect(@ans[2]).to eq(44)
    # end
  end

  describe '#run' do
    before do
      @d1 = DataIndexer.new('test collection', nil, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/stub/manifest.json')
      # @d1.index #TODO: connection is being refused by solr
      @d2 = DataIndexer.new('test collection', manifest_csv_file, nil)
      # @d2.index_csv #TODO: connection is being refused by solr
    end
    it 'is a pending test'
    # TODO: this is the same as index and index_csv, depending on params. It also commits after indexing
  end
end
