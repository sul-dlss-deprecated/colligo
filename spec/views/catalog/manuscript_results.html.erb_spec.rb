require 'spec_helper'

describe '/catalog/manuscript_results.html.erb' do
  include SolrDocumentFixtures
  before(:all) do
    @response_m = manuscript_resp
    @document_list_m = manuscript_docs
  end
  before(:each) do
    allow(view).to receive(:sidebar_classes).and_return('sidebar_classes')
    allow(view).to receive(:main_content_classes).and_return('mcc')
    stub_template 'catalog/_manuscript_search_results.html.erb' => '<div>Manuscript search results</div>'
    stub_template 'catalog/_search_sidebar.html.erb' => '<div>Search sidebar</div>'
    render
  end
  it 'should have a sidebar' do
    expect(rendered).to have_css 'div.sidebar_classes[id="sidebar"]', count: 1
  end
  it 'should include the search sidebar partial' do
    expect(rendered).to have_selector 'div#sidebar div', count: 1, text: 'Search sidebar'
  end
  it 'should have content' do
    expect(rendered).to have_css 'div.mcc[id="content"]', count: 1
  end
  it 'should include the manuscript search results partial' do
    expect(rendered).to have_selector 'div#content div', count: 1, text: 'Manuscript search results'
  end
end