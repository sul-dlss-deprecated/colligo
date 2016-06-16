require 'spec_helper'

describe 'shared/_manuscript_body.html.erb' do
  include SolrDocumentFixtures
  it 'should render the manuscript body with author' do
    allow(view).to receive(:show_manifest).and_return(true)
    allow(view).to receive(:document).and_return(manuscript_docs[0]) # title, author, manifest
    allow(view).to receive(:count).and_return(8)
    render
    expect(rendered).to have_css('div.media div.media-left')
    expect(rendered).not_to have_css('div.media div.media-left img')
    expect(rendered).to have_css('div.media div.media-body span.iiif-logo a[href="https://purl.stanford.edu/hp146pz7537/iiif/manifest.json"] img')
    expect(rendered).to have_css('div.media div.media-body h4 a[href="/manuscript/hp146pz7537?start=8"]', text: 'Gospel Lectionary')
    expect(rendered).to have_css('div.media div.media-body p', count: 1)
    expect(rendered).to have_css('div.media div.media-body p strong', text: 'St AlbansCanterbury')
  end
  it 'should render the manuscript body with thumbnail and truncated abstract' do
    allow(view).to receive(:show_manifest).and_return(true)
    allow(view).to receive(:document).and_return(manuscript_docs[2]) # title, abstract, manifest, img_info
    allow(view).to receive(:count).and_return(3)
    render
    expect(rendered).to have_css('div.media div.media-left')
    expect(rendered).to have_css('div.media div.media-left img[src="https://stacks.stanford.edu/image/iiif/xs067jx3704%2FW528_000001_300/full/!400,400/0/default.jpg"]')
    expect(rendered).to have_css('div.media div.media-body span.iiif-logo a[href="https://purl.stanford.edu/xs067jx3704/iiif/manifest.json"] img')
    expect(rendered).to have_css('div.media div.media-body h4 a[href="/manuscript/xs067jx3704?start=3"]', text: 'Walters Ms. W.528, Gospel Book')
    expect(rendered).to have_css('div.media div.media-body p', count: 1)
    expect(rendered).to have_css('div.media div.media-body p', text: 'This Gospel Book is representative of a large group of illuminated manuscripts produced during the second half of the twelfth century and possibly ...')
  end
  it 'should render the manuscript body with all the details' do
    allow(view).to receive(:show_manifest).and_return(false)
    allow(view).to receive(:document).and_return(manuscript_docs[3]) # title, abstract, author, manifest, img_info
    allow(view).to receive(:count).and_return(5)
    render
    expect(rendered).to have_css('div.media div.media-left')
    expect(rendered).to have_css('div.media div.media-left img[src="https://stacks.stanford.edu/image/iiif/pc969nh5331%2FW520_000001_300/full/!400,400/0/default.jpg"]')
    expect(rendered).not_to have_css('div.media div.media-body span.iiif-logo')
    expect(rendered).to have_css('div.media div.media-body h4 a[href="/manuscript/pc969nh5331?start=5"]', text: 'Walters Ms. W.520, Gospel Lectionary')
    expect(rendered).to have_css('div.media div.media-body p', count: 2)
    expect(rendered).to have_css('div.media div.media-body p strong', text: 'Theodore')
    expect(rendered).to have_css('div.media div.media-body p', text: 'This is an example of a Gospel Lectionary written in the archaic, majuscule form of Greek letters. Liturgical books were inherently conservative an...')
  end
end
