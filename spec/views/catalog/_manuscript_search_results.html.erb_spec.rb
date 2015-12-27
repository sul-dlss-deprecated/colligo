require 'spec_helper'

describe '/catalog/_manuscript_search_results.html.erb' do
  include SolrDocumentFixtures
  describe 'it should render manuscript search results' do
    before(:all) do
      @response_m = manuscript_resp
      @document_list_m = manuscript_docs
    end
    before(:each) do
      stub_template 'shared/_results_header.html.erb' => '<span>Results header</span>'
      stub_template 'shared/_results_footer.html.erb' => '<span>Results footer</span>'
      stub_template 'shared/_manuscript.html.erb' => '<span>Each manuscript</span>'
      stub_template 'catalog/_zero_results.html.erb' => '<span>Zero results</span>'
      allow(view).to receive(:search_action_url).and_return('/')
      allow(view).to receive(:params).and_return(q: 'gospel')
      allow(view).to receive(:render_opensearch_response_metadata).and_return(raw '<span>open search response metadata</span>')
      render
    end
    it 'should render headings' do
      expect(rendered).to have_css('h2', text: "#{@response_m['response']['numFound']} Manuscripts")
    end
    it 'should render search results header' do
      expect(rendered).to have_css('span', text: 'Results header', count: 1)
    end
    it 'should render search results' do
      expect(rendered).to have_css('span', text: 'Each manuscript', count: 10)
    end
    it 'should render search results footer' do
      expect(rendered).to have_css('span', text: 'Results footer', count: 1)
    end
  end
  describe 'it should render no manuscript search results when empty' do
    before(:all) do
      @response_m = manuscript_resp_002
      @document_list_m = manuscript_docs_002
    end
    before(:each) do
      stub_template 'shared/_results_header.html.erb' => '<span>Results header</span>'
      stub_template 'shared/_results_footer.html.erb' => '<span>Results footer</span>'
      stub_template 'shared/_manuscript.html.erb' => '<span>Each manuscript</span>'
      stub_template 'catalog/_zero_results.html.erb' => '<span>Zero results</span>'
      allow(view).to receive(:search_action_url).and_return('/')
      allow(view).to receive(:params).and_return(q: 'gospel')
      allow(view).to receive(:render_opensearch_response_metadata).and_return(raw '<span>open search response metadata</span>')
      render
    end
    it 'should render headings' do
      expect(rendered).to have_css('h2', text: '0 Manuscripts')
    end
    it 'should render search results header' do
      expect(rendered).to have_css('span', text: 'Results header', count: 1)
    end
    it 'should not render search results' do
      expect(rendered).not_to have_css('span', text: 'Each manuscript')
    end
    it 'should render search results footer' do
      expect(rendered).not_to have_css('span', text: 'Results footer')
    end
    it 'should render zero results' do
      expect(rendered).to have_css('span', text: 'Zero results', count: 1)
    end
  end
end
