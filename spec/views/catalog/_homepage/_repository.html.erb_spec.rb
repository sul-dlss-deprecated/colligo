require 'rails_helper'

describe '/catalog/_homepage/_repository.html.erb' do
  include SolrDocumentFixtures
  before(:all) do
    @response = manuscript_resp
  end
  before(:each) do
    allow(view).to receive(:path_for_facet).and_return('/')
    allow(view).to receive(:search_action_path).and_return('/')
    render
  end
  it 'should render headings' do
    expect(rendered).to match('<h3.*?>by repository</h3>')
  end
  it 'should have links with image tags' do
    expect(rendered).to have_css('a.btn-secondary img', minimum: 3)
    expect(rendered).to match %r{/assets/other-\S+\.png}
    expect(rendered).to match %r{/assets/stanford-\S+\.png}
    expect(rendered).to match %r{/assets/parker-\S+\.png}
    expect(rendered).to match %r{/assets/walter-\S+\.png}
  end
end
