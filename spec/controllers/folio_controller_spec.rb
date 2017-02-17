require 'spec_helper'

describe FolioController do
  describe '#show folio page' do
    include SolrDocumentFixtures
    include IiifManifestFixtures
    before do
      allow(controller).to receive(:manuscript)
      controller.instance_variable_set(:@manuscript, manuscript_docs_003)
      response1 = File.open("#{::Rails.root}/spec/fixtures/iiif_manifest_records/manifest_001.json").read
      stub_request(:get, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/manifest.json')
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: response1, headers: {})
      get :show, manuscript_id: 'kq131cs7229', id: 'f. 8r'
    end
    it 'should have manuscript details' do
      expect(controller.instance_variable_get('@manuscript')).not_to be_nil
      expect(controller.instance_variable_get('@manuscript')).to be_a(Hash)
      expect(controller.instance_variable_get('@manuscript')['druid']).to eq('kq131cs7229')
    end
    it 'should have canvas_id, previous and next folio' do
      expect(controller.instance_variable_get('@canvas_id')).not_to be_nil
      expect(controller.instance_variable_get('@canvas_id')).to eq('http://dms-data.stanford.edu/Stanford/kq131cs7229/canvas/canvas-3')
      expect(controller.instance_variable_get('@prev_doc'))
      expect(controller.instance_variable_get('@next_doc'))
    end
    it 'should have annotations' do
      expect(controller.instance_variable_get('@annotations')).not_to be_nil
      expect(controller.instance_variable_get('@annotations')).to be_a(Array)
      expect(controller.instance_variable_get('@annotations').length).to eq(0)
    end
    it 'should have transcriptions' do
      expect(controller.instance_variable_get('@transcriptions')).not_to be_nil
      expect(controller.instance_variable_get('@transcriptions')).to be_a(Array)
      expect(controller.instance_variable_get('@transcriptions').length).to eq(19)
    end
    it 'should render blacklight layout' do
      response.should render_template('layouts/blacklight')
    end
    it 'should render show template' do
      response.should render_template('folio/show')
    end
  end

  describe '#folio_label in json' do
    include SolrDocumentFixtures
    include IiifManifestFixtures
    it 'should receive the label as a json object' do
      allow(controller).to receive(:manuscript)
      controller.instance_variable_set(:@manuscript, manuscript_docs_003)
      response1 = File.open("#{::Rails.root}/spec/fixtures/iiif_manifest_records/manifest_001.json").read
      stub_request(:get, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/manifest.json')
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: response1, headers: {})
      @expected = { folio: 'f. 9r' }.to_json
      get :folio_label, manuscript_id: 'kq131cs7229', id: 'f. 8r', canvas_id: 'http://dms-data.stanford.edu/Stanford/kq131cs7229/canvas/canvas-5', format: 'json'
      response.body.should eq(@expected)
    end
  end

  describe '#annotations' do
    include SolrDocumentFixtures
    before do
      allow(controller).to receive(:params).and_return(manuscript_id: 'kq131cs7229', id: 'f. 8r')
      query_params = { q: 'druid:kq131cs7229 AND folio:"f. 8r"', rows: 1000, sort: 'sort_index asc' }
      expect(controller).to receive(:search_results).with(query_params).and_return([annotation_resp, annotation_docs])
      controller.send(:annotations)
    end
    it 'should have annotations' do
      expect(controller.instance_variable_get('@annotations')).not_to be_nil
      expect(controller.instance_variable_get('@annotations')).to be_a(Array)
      expect(controller.instance_variable_get('@annotations').length).to eq(10)
    end
  end

  describe '#transcriptions' do
    include SolrDocumentFixtures
    before do
      allow(controller).to receive(:params).and_return(manuscript_id: 'kq131cs7229', id: 'f. 8r')
      query_params = { q: 'druid:kq131cs7229 AND folio:"f. 8r"', rows: 1000, sort: 'sort_index asc' }
      expect(controller).to receive(:search_results).with(query_params).and_return([transcription_resp, transcription_docs])
      controller.send(:transcriptions)
    end
    it 'should have transcriptions' do
      expect(controller.instance_variable_get('@transcriptions')).not_to be_nil
      expect(controller.instance_variable_get('@transcriptions')).to be_a(Array)
      expect(controller.instance_variable_get('@transcriptions').length).to eq(10)
    end
  end

  describe '#manuscript' do
    include SolrDocumentFixtures
    before do
      allow(controller).to receive(:params).and_return(manuscript_id: 'kq131cs7229', id: 'f. 8r')
      query_params = { q: 'druid:kq131cs7229', rows: 1 }
      expect(controller).to receive(:search_results).with(query_params).and_return([manuscript_resp_003, [manuscript_docs_003]])
      controller.send(:manuscript)
    end
    it 'should have manuscript details' do
      expect(controller.instance_variable_get('@manuscript')).not_to be_nil
      expect(controller.instance_variable_get('@manuscript')).to be_a(Hash)
      expect(controller.instance_variable_get('@manuscript')['druid']).to eq('kq131cs7229')
    end
  end

  describe '#current_prev_and_next_folio' do
    include SolrDocumentFixtures
    include IiifManifestFixtures
    before do
      controller.instance_variable_set(:@manuscript, manuscript_docs_003)
      response1 = File.open("#{::Rails.root}/spec/fixtures/iiif_manifest_records/manifest_001.json").read
      stub_request(:get, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/manifest.json')
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: response1, headers: {})
    end
    it 'should have canvass id and next folio' do
      allow(controller).to receive(:params).and_return(manuscript_id: 'kq131cs7229', id: 'f. 8r')
      controller.send(:current_prev_and_next_folio)
      next_folio = {
        '@id' => 'http://dms-data.stanford.edu/Stanford/kq131cs7229/canvas/canvas-4',
        'label' => 'f. 8v',
        'motivation' => 'sc:painting',
        '@type' => 'oa:Annotation',
        'img' => 'http://stacks.stanford.edu/image/kq131cs7229/kq131cs7229_05_0006'
      }
      expect(controller.instance_variable_get('@previous_folio')).to be_nil
      expect(controller.instance_variable_get('@canvas_id')).to eq('http://dms-data.stanford.edu/Stanford/kq131cs7229/canvas/canvas-3')
      expect(controller.instance_variable_get('@next_folio')).to eq(next_folio)
    end
    it 'should have canvass id, previous folio and next folio' do
      allow(controller).to receive(:params).and_return(manuscript_id: 'kq131cs7229', id: 'f. 8v')
      controller.send(:current_prev_and_next_folio)
      prev_folio = {
        '@id' => 'http://dms-data.stanford.edu/Stanford/kq131cs7229/canvas/canvas-3',
        'label' => 'f. 8r',
        'motivation' => 'sc:painting',
        '@type' => 'oa:Annotation',
        'img' => 'http://stacks.stanford.edu/image/kq131cs7229/sulmss_misc305_008r_SM'
      }
      next_folio = {
        '@id' => 'http://dms-data.stanford.edu/Stanford/kq131cs7229/canvas/canvas-5',
        'label' => 'f. 9r',
        'motivation' => 'sc:painting',
        '@type' => 'oa:Annotation',
        'img' => 'http://stacks.stanford.edu/image/kq131cs7229/kq131cs7229_05_0019'
      }
      expect(controller.instance_variable_get('@previous_folio')).to eq(prev_folio)
      expect(controller.instance_variable_get('@canvas_id')).to eq('http://dms-data.stanford.edu/Stanford/kq131cs7229/canvas/canvas-4')
      expect(controller.instance_variable_get('@next_folio')).to eq(next_folio)
    end
    it 'should have canvass id and previous folio' do
      allow(controller).to receive(:params).and_return(manuscript_id: 'kq131cs7229', id: 'f. 104v')
      controller.send(:current_prev_and_next_folio)
      prev_folio = {
        '@id' => 'http://dms-data.stanford.edu/Stanford/kq131cs7229/canvas/canvas-35',
        'label' => 'f. 104r',
        'motivation' => 'sc:painting',
        '@type' => 'oa:Annotation',
        'img' => 'http://stacks.stanford.edu/image/kq131cs7229/kq131cs7229_05_0015'
      }
      expect(controller.instance_variable_get('@previous_folio')).to eq(prev_folio)
      expect(controller.instance_variable_get('@canvas_id')).to eq('http://dms-data.stanford.edu/Stanford/kq131cs7229/canvas/canvas-36')
      expect(controller.instance_variable_get('@next_folio')).to be_nil
    end
  end

  describe '#folio_from_canvas' do
    include SolrDocumentFixtures
    include IiifManifestFixtures
    it 'should receive the label' do
      controller.instance_variable_set(:@manuscript, manuscript_docs_003)
      response1 = File.open("#{::Rails.root}/spec/fixtures/iiif_manifest_records/manifest_001.json").read
      stub_request(:get, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/manifest.json')
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: response1, headers: {})
      allow(controller).to receive(:params).and_return(manuscript_id: 'kq131cs7229', id: 'f. 8r',
                                                       canvas_id: 'http://dms-data.stanford.edu/Stanford/kq131cs7229/canvas/canvas-30')
      ans = controller.send(:folio_from_canvas)
      ans.should eq('f. 93v')
    end
  end
end
