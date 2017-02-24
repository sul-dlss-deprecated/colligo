require 'rails_helper'

describe '/catalog/_bentopage/_transcriptions.html.erb' do
  include SolrDocumentFixtures
  describe 'it should render transcriptions' do
    before(:all) do
      @response_t = transcription_resp
      @document_list_t = transcription_docs
    end
    before(:each) do
      stub_template 'shared/_transcription.html.erb' => '<span>Each transcription</span>'
      allow(view).to receive(:search_action_url).and_return('/')
      allow(view).to receive(:params).and_return(q: 'gospel')
      render
    end
    it 'should render headings' do
      expect(rendered).to match('<h2.*?>Transcriptions</h2>')
    end
    it 'should render links to transcriptions' do
      expect(rendered).to have_css('form', count: 1)
      expect(rendered).to have_css('form button', count: 1)
      expect(rendered).to have_css('input#search_field_transcriptions[value=transcriptions]', visible: false)
      expect(rendered).to have_css('input#q_transcriptions[value=gospel]', visible: false)
      expect(rendered).to have_css('h4 span.glyphicon-forward')
      expect(rendered).to have_css('form button', text: "See all #{@response_t['response']['numFound']}")
    end
    it 'should render 6 transcription partials' do
      expect(rendered).to have_css('span', text: 'Each transcription', count: 6)
    end
  end
  describe 'it should display heading if no results' do
    before(:all) do
      @response_t = transcription_resp_002
      @document_list_t = transcription_docs_002
    end
    before(:each) do
      stub_template 'shared/_transcription.html.erb' => '<span>Each transcription</span>'
      allow(view).to receive(:search_action_url).and_return('/')
      allow(view).to receive(:params).and_return(q: 'foobar')
      render
    end
    it 'should render headings' do
      expect(rendered).to match('<h2.*?>Transcriptions</h2>')
    end
    it 'should render no results text and no links' do
      expect(rendered).not_to have_css('form')
      expect(rendered).to have_css('h4', text: ' No results')
    end
    it 'should not render any transcription partials' do
      expect(rendered).not_to have_css('span', text: 'Each transcription')
    end
  end
end
