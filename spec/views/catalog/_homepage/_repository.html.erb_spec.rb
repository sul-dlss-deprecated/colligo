require 'spec_helper'

describe '/catalog/_homepage/_repository.html.erb' do
  include SolrDocumentFixtures
  before(:all) do
    @response = manuscript_resp
  end
  before(:each) do
    allow(view).to receive(:blacklight_config).and_return(CatalogController.new.blacklight_config)
    allow(view).to receive(:search_action_path).and_return('/')
    render
  end
  it 'should render headings' do
    rendered.should match('<h3.*?>by repository</h3>')
  end
  it 'should have links with image tags' do
    expect(rendered).to have_css('a.btn-secondary img', minimum: 3)
    rendered.should include('/assets/other.png')
    rendered.should include('/assets/stanford.png')
    rendered.should include('/assets/parker.png')
    rendered.should include('/assets/walter.png')
  end
end
