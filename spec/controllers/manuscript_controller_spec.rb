require 'spec_helper'

describe ManuscriptController do
  describe '#show manuscript page' do
    include IiifManifestFixtures
    before(:all) do
      sd = SolrDocument.new
      @keys_defined = sd.all_display_fields - sd.single_valued_display_fields
    end
    before do
      response1 = File.open("#{::Rails.root}/spec/fixtures/iiif_manifest_records/manifest_001.json").read
      stub_request(:get, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/manifest.json')
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: response1, headers: {})
      get :show, id: 'kq131cs7229'
    end
    it 'should have manuscript with all multivalued keys not nil' do
      expect(controller.instance_variable_get('@response')).not_to be_nil
      expect(controller.instance_variable_get('@document')).not_to be_nil
      expect(controller.instance_variable_get('@document')['druid']).to eq('kq131cs7229')
      expect(@keys_defined - controller.instance_variable_get('@document').keys).to be_empty
    end
    it 'should have manifest contents' do
      expect(controller.instance_variable_get('@contents')).not_to be_nil
      expect(controller.instance_variable_get('@contents')).to be_a(Array)
      expect(controller.instance_variable_get('@contents').length).to eq(36)
    end
    it 'should have related annotations' do
      expect(controller.instance_variable_get('@related_annotations')).not_to be_nil
      expect(controller.instance_variable_get('@related_annotations')).to be_a(Integer)
    end
    it 'should have related transcriptions' do
      expect(controller.instance_variable_get('@related_transcriptions')).not_to be_nil
      expect(controller.instance_variable_get('@related_transcriptions')).to be_a(Integer)
    end
    it 'should have previous and next document' do
      expect(controller.instance_variable_get('@prev_doc')).not_to be_nil
      expect(controller.instance_variable_get('@prev_doc')).to be_a(Hash)
      expect(controller.instance_variable_get('@next_doc')).not_to be_nil
      expect(controller.instance_variable_get('@next_doc')).to be_a(Hash)
    end
    it 'should render blacklight layout' do
      response.should render_template('layouts/blacklight')
    end
    it 'should render show template' do
      response.should render_template('manuscript/show')
    end
  end

  describe 'get related_content in json' do
    it 'should be a json object' do
      allow(controller).to receive(:folio_related_transcriptions).and_return([10, 'first line of transcription'])
      allow(controller).to receive(:folio_related_annotations).and_return(5)
      @expected = {
        annotations: 5,
        transcriptions: 10,
        first_transcription: 'first line of transcription'
      }.to_json
      get :related_content, id: 'kq131cs7229', folio: '2r', format: 'json'
      response.body.should eq(@expected)
    end
  end

  describe '#folio_related_annotations' do
    include SolrDocumentFixtures
    it 'should have a response' do
      allow(controller).to receive(:params).and_return(id: 'kq131cs7229', folio: 'f. 8r')
      query_params = { q: 'druid:kq131cs7229 AND folio:"f. 8r"', rows: 0 }
      expect(controller).to receive(:search_results).with(query_params).and_return([annotation_resp_003, annotation_docs_003])
      ans = controller.send(:folio_related_annotations)
      ans.should eq(annotation_resp_003['response']['numFound'])
    end
  end

  describe '#folio_related_transcriptions' do
    include SolrDocumentFixtures
    it 'should have a response and a transcription' do
      allow(controller).to receive(:params).and_return(id: 'kq131cs7229', folio: 'f. 8r')
      query_params = { q: 'druid:kq131cs7229 AND folio:"f. 8r"', rows: 1, sort: 'sort_index asc' }
      expect(controller).to receive(:search_results).with(query_params).and_return([transcription_resp_003, transcription_docs_003])
      ans = controller.send(:folio_related_transcriptions)
      ans.should eq([transcription_resp_003['response']['numFound'], transcription_docs_003[0]['body_chars_display']])
    end
    it 'should not have a folio parameter' do
      allow(controller).to receive(:params).and_return(id: 'kq131cs7229')
      query_params = { q: 'druid:kq131cs7229', rows: 1, sort: 'sort_index asc' }
      expect(controller).to receive(:search_results).with(query_params).and_return([transcription_resp_003, transcription_docs_003])
      ans = controller.send(:folio_related_transcriptions)
      ans.should eq([transcription_resp_003['response']['numFound'], transcription_docs_003[0]['body_chars_display']])
    end
    it 'should have a response and no transcription' do
      allow(controller).to receive(:params).and_return(id: 'some_unknown_id', folio: '12r')
      query_params = { q: 'druid:some_unknown_id AND folio:"12r"', rows: 1, sort: 'sort_index asc' }
      expect(controller).to receive(:search_results).with(query_params).and_return([transcription_resp_002, transcription_docs_002])
      ans = controller.send(:folio_related_transcriptions)
      ans.should eq([transcription_resp_002['response']['numFound'], nil])
    end
  end

  describe '#m_previous_and_next_documents' do
    include SolrDocumentFixtures
    before do
      m_params = { f: { language: ['Latin'] }, q: 'gospel', numFound: 17, start: 4, qt: 'descriptions' }
      allow(controller).to receive(:current_query).and_return(m_params)
      allow(controller).to receive(:get_previous_and_next_documents_for_search).with(m_params[:start], m_params, {}).and_return(prev_and_next_docs)
      controller.send(:m_previous_and_next_documents)
    end
    it 'should have the prev doc' do
      expect(controller.instance_variable_get('@prev_doc')).to be_a(Hash)
      expect(controller.instance_variable_get('@prev_doc').keys).to eq(%w(path title))
      expect(controller.instance_variable_get('@prev_doc')['path']).to eq('http://test.host/manuscript/xs067jx3704?start=3')
      expect(controller.instance_variable_get('@prev_doc')['title']).to eq('Walters Ms. W.528, Gospel Book')
    end
    it 'should have the next doc' do
      expect(controller.instance_variable_get('@next_doc')).to be_a(Hash)
      expect(controller.instance_variable_get('@next_doc').keys).to eq(%w(path title))
      expect(controller.instance_variable_get('@next_doc')['path']).to eq('http://test.host/manuscript/kx761rc2825?start=5')
      expect(controller.instance_variable_get('@next_doc')['title']).to eq('Walters Ms. W.751, Corvey Gospel fragment')
    end
  end

  describe '#current_query' do
    it 'should need the session variable' do
      session[:m_last_search_query] = nil
      allow(controller).to receive(:params).and_return(start: 4)
      ans = controller.send(:current_query)
      expect(ans).to be_nil
    end
    it 'should need the start param' do
      session[:m_last_search_query] = {
        f: { language: ['Latin'] },
        q: 'gospel',
        numFound: 62
      }.to_json
      allow(controller).to receive(:params).and_return({})
      ans = controller.send(:current_query)
      expect(ans).to be_nil
    end
    it 'should need an integer start param' do
      session[:m_last_search_query] = {
        f: { language: ['Latin'] },
        q: 'gospel',
        numFound: 62
      }.to_json
      allow(controller).to receive(:params).and_return(start: '2v')
      ans = controller.send(:current_query)
      expect(ans).to be_nil
    end
    it 'should return all the needed parameters' do
      session[:m_last_search_query] = {
        f: { language: ['Latin'] },
        q: 'gospel',
        numFound: 62
      }.to_json
      allow(controller).to receive(:params).and_return(start: '2')
      @expected = {
        f: { 'language' => ['Latin'] },
        q: 'gospel',
        numFound: 62,
        start: 2,
        qt: 'descriptions'
      }
      ans = controller.send(:current_query)
      expect(ans).to eq(@expected)
    end
  end
end
