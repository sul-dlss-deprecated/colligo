require 'spec_helper'

describe 'Bookmarks', type: :feature, js: true do
  it 'add and remove bookmarks from search results' do
    visit root_path
    click_link 'Descriptions'
    sleep 2
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    fill_in 'q', with: 'gospel'
    click_button 'search'
    expect(page).to have_css('form[data-doc-id="hp146pz7537"] button.bookmark_add', text: 'bookmark')
    click_button 'bookmark_toggle_hp146pz7537'
    expect(page).to have_content 'Successfully added bookmark.'
    expect(page).to have_css('form[data-doc-id="hp146pz7537"] button.bookmark_remove', text: 'bookmarked')
    fill_in 'q', with: 'gospel'
    click_button 'search'
    click_button 'bookmark_toggle_hp146pz7537'
    expect(page).to have_content 'Successfully removed bookmark.'
    expect(page).to have_css('form[data-doc-id="hp146pz7537"] button.bookmark_add', text: 'bookmark')
  end
end
