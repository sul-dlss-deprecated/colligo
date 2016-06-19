require 'spec_helper'

describe 'Manuscript nav bar', type: :feature, js: true do
  it 'should have set the active navigation element' do
    response1 = File.open("#{::Rails.root}/spec/fixtures/iiif_manifest_records/manifest_002.json").read
    stub_request(:get, 'http://dms-data.stanford.edu/data/manifests/BnF/jr903ng8662/manifest.json')
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: response1, headers: {})
    visit '/manuscript/jr903ng8662'
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li.active a[href="#summary"]', count: 1, text: 'Summary')
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#description"]', count: 1, text: 'Description')
    click_link 'Description'
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#summary"]', count: 1, text: 'Summary')
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li.active a[href="#description"]', count: 1, text: 'Description')
  end
end
