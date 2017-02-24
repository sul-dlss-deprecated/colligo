require 'rails_helper'

describe 'manuscript/_header.html.erb' do
  include SolrDocumentFixtures
  before(:all) do
    @document = manuscript_docs[0]
    @response = manuscript_resp
  end
  it 'should render the manuscript title, manifest, breadcrumbs and bookmark' do
    stub_template 'manuscript/_breadcrumbs.html.erb' => '<span>breadcrumbs</span>'
    stub_template 'shared/_bookmark_control.html.erb' => 'Bookmark'
    render
    expect(rendered).to have_css('div.media div.media-body h1', text: 'Gospel Lectionary')
    expect(rendered).to have_css('div.media div.media-right div.iiif-logo a[href="https://purl.stanford.edu/hp146pz7537/iiif/manifest.json"] img')
    expect(rendered).to have_css('div span', text: 'breadcrumbs')
    expect(rendered).to have_css('div span', text: 'Bookmark')
  end
end
