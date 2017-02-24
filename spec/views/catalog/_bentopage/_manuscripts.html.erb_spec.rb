require 'rails_helper'

describe '/catalog/_bentopage/_manuscripts.html.erb' do
  include SolrDocumentFixtures
  describe 'it should render manuscripts' do
    before(:all) do
      @response_m = manuscript_resp
      @document_list_m = manuscript_docs
    end
    before(:each) do
      stub_template 'shared/_manuscript.html.erb' => '<span>Each manuscript</span>'
      allow(view).to receive(:search_action_url).and_return('/')
      allow(view).to receive(:params).and_return(q: 'gospel')
      render
    end
    it 'should render headings' do
      expect(rendered).to match('<h2.*?>Manuscripts</h2>')
    end
    it 'should render links to manuscripts' do
      expect(rendered).to have_css('form', count: 1)
      expect(rendered).to have_css('form button', count: 1)
      expect(rendered).to have_css('input#search_field_descriptions[value=descriptions]', visible: false)
      expect(rendered).to have_css('input#q_descriptions[value=gospel]', visible: false)
      expect(rendered).to have_css('h4 span.glyphicon-forward')
      expect(rendered).to have_css('form button', text: "See all #{@response_m['response']['numFound']}")
    end
    it 'should render 4 manuscript partials' do
      expect(rendered).to have_css('span', text: 'Each manuscript', count: 4)
    end
  end
  describe 'it should display heading if no results' do
    before(:all) do
      @response_m = manuscript_resp_002
      @document_list_m = manuscript_docs_002
    end
    before(:each) do
      stub_template 'shared/_manuscript.html.erb' => '<span>Each manuscript</span>'
      allow(view).to receive(:search_action_url).and_return('/')
      allow(view).to receive(:params).and_return(q: 'foobar')
      render
    end
    it 'should render headings' do
      expect(rendered).to match('<h2.*?>Manuscripts</h2>')
    end
    it 'should render no results text and no links' do
      expect(rendered).not_to have_css('form')
      expect(rendered).to have_css('h4', text: ' No results')
    end
    it 'should not render any manuscript partials' do
      expect(rendered).not_to have_css('span', text: 'Each manuscript')
    end
  end
end
