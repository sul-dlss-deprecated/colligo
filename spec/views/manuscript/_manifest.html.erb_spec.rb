require 'rails_helper'

describe 'manuscript/_manifest.html.erb' do
  include SolrDocumentFixtures
  include IiifManifestFixtures
  it 'should render the manifest container with data' do
    @document = manuscript_docs[0]
    @contents = manifest_contents
    render
    expect(rendered).to have_css('div#viewer[data-manifest-uri="https://purl.stanford.edu/hp146pz7537/iiif/manifest.json"]')
    expect(rendered).to have_css('div#viewer[data-canvas-id="https://purl.stanford.edu/bb389yg4719/iiif/canvas-0"]')
  end
  it 'should render nothing if no manifest uri' do
    @document = {}
    @contents = manifest_contents
    render
    expect(rendered).not_to have_css('div#viewer')
  end
  it 'should render nothing if no canvas id' do
    @document = manuscript_docs[0]
    @contents = {}
    render
    expect(rendered).not_to have_css('div#viewer')
  end
  it 'should render nothing if no canvas id and manifest uri' do
    @document = {}
    @contents = {}
    render
    expect(rendered).not_to have_css('div#viewer')
  end
end
