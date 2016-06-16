require 'spec_helper'

describe 'Bookmarks', type: :feature, js: true do
  it 'should add and remove bookmarks from search results' do
    visit root_path
    click_link 'Descriptions'
    sleep 2
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    fill_in 'q', with: 'gospel'
    click_button 'search'
    expect(page).to have_css('form.pull-right[data-doc-id="hp146pz7537"] button.bookmark_add', text: 'bookmark')
    click_button 'bookmark_toggle_hp146pz7537'
    # Bookmark is through ajax call, so should not see successfult message
    # expect(page).to have_content 'Successfully added bookmark.'
    expect(page).to have_css('form.pull-right[data-doc-id="hp146pz7537"] button.bookmark_remove', text: 'bookmarked')
    fill_in 'q', with: 'gospel'
    click_button 'search'
    click_button 'bookmark_toggle_hp146pz7537'
    # expect(page).to have_content 'Successfully removed bookmark.'
    expect(page).to have_css('form.pull-right[data-doc-id="hp146pz7537"] button.bookmark_add', text: 'bookmark')
  end
  it 'should add and remove bookmarks from manuscript' do
    visit '/manuscript/kq131cs7229'
    expect(page).to have_css('form.inline[data-doc-id="kq131cs7229"] button.bookmark_inverse_add', text: 'bookmark')
    click_button 'bookmark_toggle_kq131cs7229'
    # expect(page).to have_content 'Successfully added bookmark.'
    expect(page).to have_css('form.inline[data-doc-id="kq131cs7229"] button.bookmark_inverse_remove', text: 'bookmarked')
    visit '/manuscript/kq131cs7229'
    expect(page).to have_css('form.inline[data-doc-id="kq131cs7229"] button.bookmark_inverse_remove', text: 'bookmarked')
    click_button 'bookmark_toggle_kq131cs7229'
    # expect(page).to have_content 'Successfully removed bookmark.'
    expect(page).to have_css('form.inline[data-doc-id="kq131cs7229"] button.bookmark_inverse_add', text: 'bookmark')
  end
end
