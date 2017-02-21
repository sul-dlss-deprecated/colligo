require 'spec_helper'

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
    rendered.should match('<h3.*?>by repository</h3>')
  end
  it 'should have links with image tags' do
    expect(rendered).to have_css('a.btn-secondary img', minimum: 3)
    rendered.should match %r{/assets/other-\S+\.png}
    rendered.should match %r{/assets/stanford-\S+\.png}
    rendered.should match %r{/assets/parker-\S+\.png}
    rendered.should match %r{/assets/walter-\S+\.png}
  end
end
