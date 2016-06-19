require 'spec_helper'

describe 'Bookmarks', type: :feature, js: true do
  it 'should add and remove bookmarks from search results' do
    visit root_path
    click_link 'Descriptions'
    sleep 2
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    fill_in 'q', with: 'manuscript'
    click_button 'search'
    expect(page).to have_css('form.pull-right[data-doc-id="jr903ng8662"] div.checkbox.toggle_bookmark label.toggle_bookmark span', text: 'bookmark')
    b = page.find('form.pull-right[data-doc-id="jr903ng8662"] div.checkbox.toggle_bookmark label.toggle_bookmark span')
    b.click
    sleep 1
    # Bookmark is through ajax call, so should not see successfult message
    # expect(page).to have_content 'Successfully added bookmark.'
    expect(page).to have_css('form.pull-right[data-doc-id="jr903ng8662"] label.toggle_bookmark span', text: 'bookmarked')
    fill_in 'q', with: 'manuscript'
    click_button 'search'
    expect(page).to have_css('form.pull-right[data-doc-id="jr903ng8662"] div.checkbox.toggle_bookmark label.toggle_bookmark span', text: 'bookmarked')
    b = page.find('form.pull-right[data-doc-id="jr903ng8662"] div.checkbox.toggle_bookmark label.toggle_bookmark span')
    b.click
    sleep 1
    expect(page).to have_css('form.pull-right[data-doc-id="jr903ng8662"] label.toggle_bookmark span', text: 'bookmark')
  end
  it 'should add and remove bookmarks from manuscript' do
    response1 = File.open("#{::Rails.root}/spec/fixtures/iiif_manifest_records/manifest_001.json").read
    stub_request(:get, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/manifest.json')
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: response1, headers: {})
    # Page isn't getting loaded
    visit '/manuscript/kq131cs7229'
    sleep 2
    expect(page).to have_css('form.bookmark_toggle.bookmark_inverse.inline[data-doc-id="kq131cs7229"] div.checkbox.toggle_bookmark label.toggle_bookmark span', text: 'bookmark')
    b = page.find('form.inline[data-doc-id="kq131cs7229"] div.checkbox.toggle_bookmark label.toggle_bookmark span')
    b.click
    sleep 1
    expect(page).to have_css('form.bookmark_toggle.bookmark_inverse.inline[data-doc-id="kq131cs7229"] div.checkbox.toggle_bookmark label.toggle_bookmark span', text: 'bookmarked')
    visit '/manuscript/kq131cs7229'
    expect(page).to have_css('form.bookmark_toggle.bookmark_inverse.inline[data-doc-id="kq131cs7229"] div.checkbox.toggle_bookmark label.toggle_bookmark span', text: 'bookmarked')
    b = page.find('form.bookmark_toggle.bookmark_inverse.inline[data-doc-id="kq131cs7229"] div.checkbox.toggle_bookmark label.toggle_bookmark span')
    b.click
    sleep 1
    expect(page).to have_css('form.bookmark_toggle.bookmark_inverse.inline[data-doc-id="kq131cs7229"] div.checkbox.toggle_bookmark label.toggle_bookmark span', text: 'bookmark')
  end
end
