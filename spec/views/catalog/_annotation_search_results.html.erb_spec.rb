require 'spec_helper'

describe '/catalog/_annotation_search_results.html.erb' do
  include SolrDocumentFixtures
  before(:each) do
    stub_template 'shared/_results_footer.html.erb' => '<span>Results footer</span>'
    stub_template 'shared/_annotation.html.erb' => '<span>Each annotation</span>'
    stub_template 'catalog/_zero_results.html.erb' => '<span>Zero results</span>'
    allow(view).to receive(:search_action_url).and_return('/')
    allow(view).to receive(:params).and_return(q: 'gospel')
    allow(view).to receive(:render_opensearch_response_metadata).and_return(raw '<span>open search response metadata</span>')
    render
  end
  describe 'it should render annotation search results' do
    before(:all) do
      @response_a = annotation_resp
      @document_list_a = annotation_docs
    end
    it 'should render search results' do
      expect(rendered).to have_css('span', text: 'Each annotation', count: 10)
    end
    it 'should render search results footer' do
      expect(rendered).to have_css('span', text: 'Results footer', count: 1)
    end
  end
  describe 'it should render no annotation search results when empty' do
    before(:all) do
      @response_a = annotation_resp_002
      @document_list_a = annotation_docs_002
    end
    it 'should not render search results' do
      expect(rendered).not_to have_css('span', text: 'Each manuscript')
    end
    it 'should not render search results footer' do
      expect(rendered).not_to have_css('span', text: 'Results footer')
    end
    it 'should render zero results' do
      expect(rendered).to have_css('span', text: 'Zero results', count: 1)
    end
  end
end
