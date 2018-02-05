require 'rails_helper'

describe 'Search page top', type: :feature, js: true do
  it 'should have the top link for manuscripts with less than 10 results' do
    visit root_path
    click_link 'Descriptions'
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    fill_in 'q', with: 'manuscripts'
    click_button 'search'
    expect(page).to have_css('h2', text: '4 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 4)
    expect(page).to have_css('div.footer-top a.btn-top[href="#"]', text: 'Top')
    expect(page).to have_css('div.footer-top a.btn-top[href="#"] span.glyphicon-arrow-up')
    click_link 'Top'
  end
  it 'should not have top link if no results for manuscripts' do
    visit root_path
    click_link 'Descriptions'
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    fill_in 'q', with: 'foobar'
    click_button 'search'
    expect(page).to have_css('h2', text: '0 Manuscripts')
    expect(page).not_to have_css('div.footer-per-page')
  end
  it 'should have the top link for transcriptions' do
    visit root_path
    click_link 'Transcriptions'
    page.evaluate_script('document.getElementById("main_search_field").value') == 'transcriptions'
    fill_in 'q', with: 'jesus'
    click_button 'search'
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.footer-top a.btn-top[href="#"]', text: 'Top')
    expect(page).to have_css('div.footer-top a.btn-top[href="#"] span.glyphicon-arrow-up')
    # select next page - should have top
    click_link '1 - 10'
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.footer-top a.btn-top[href="#"]', text: 'Top')
    expect(page).to have_css('div.footer-top a.btn-top[href="#"] span.glyphicon-arrow-up')
    # select next page - should have top
    click_link '11 - 20'
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 4)
    expect(page).to have_css('div.footer-top a.btn-top[href="#"]', text: 'Top')
    expect(page).to have_css('div.footer-top a.btn-top[href="#"] span.glyphicon-arrow-up')
  end
  it 'should not have top link if no results' do
    visit root_path
    click_link 'Transcriptions'
    page.evaluate_script('document.getElementById("main_search_field").value') == 'transcriptions'
    fill_in 'q', with: 'foobar'
    click_button 'search'
    expect(page).to have_css('h2', text: '0 Transcriptions')
    expect(page).not_to have_css('div.footer-per-page')
  end
end
