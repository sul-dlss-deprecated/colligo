require 'spec_helper'

describe 'Search page top', type: :feature, js: true do
  it 'should have the top link for manuscripts' do
    visit root_path
    click_link 'Descriptions'
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    fill_in 'q', with: 'gospel'
    click_button 'search'
    expect(page).to have_css('h2', text: '62 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.footer-top a.btn-top[href="#"]', text: 'Top')
    expect(page).to have_css('div.footer-top a.btn-top[href="#"] span.glyphicon-arrow-up')
    click_link 'Top'
    page.evaluate_script("$('body.scrollTop()')") == 0
    # select 50 per page - should have top
    click_link 50
    expect(page).to have_css('h2', text: '62 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 50)
    expect(page).to have_css('div.footer-top a.btn-top[href="#"]', text: 'Top')
    expect(page).to have_css('div.footer-top a.btn-top[href="#"] span.glyphicon-arrow-up')
    click_link 'Top'
    page.evaluate_script("$('body.scrollTop()')") == 0
    # select next page - should have top
    click_link '1 - 50'
    expect(page).to have_css('h2', text: '62 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 12)
    expect(page).to have_css('div.footer-top a.btn-top[href="#"]', text: 'Top')
    expect(page).to have_css('div.footer-top a.btn-top[href="#"] span.glyphicon-arrow-up')
    click_link 'Top'
    page.evaluate_script("$('body.scrollTop()')") == 0
    # select previous page - should have top
    click_link 'previouspage'
    expect(page).to have_css('h2', text: '62 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 50)
    expect(page).to have_css('div.footer-top a.btn-top[href="#"]', text: 'Top')
    expect(page).to have_css('div.footer-top a.btn-top[href="#"] span.glyphicon-arrow-up')
    click_link 'Top'
    page.evaluate_script("$('body.scrollTop()')") == 0
    # should have top link even if total is 1 manuscript
    fill_in 'q', with: 'israel'
    click_button 'search'
    expect(page).to have_css('h2', text: '1 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 1)
    expect(page).to have_css('div.footer-top a.btn-top[href="#"]', text: 'Top')
    expect(page).to have_css('div.footer-top a.btn-top[href="#"] span.glyphicon-arrow-up')
    click_link 'Top'
    page.evaluate_script("$('body.scrollTop()')") == 0
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
    click_link 'Top'
    page.evaluate_script("$('body.scrollTop()')") == 0
    # select next page - should have top
    click_link '1 - 10'
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.footer-top a.btn-top[href="#"]', text: 'Top')
    expect(page).to have_css('div.footer-top a.btn-top[href="#"] span.glyphicon-arrow-up')
    click_link 'Top'
    page.evaluate_script("$('body.scrollTop()')") == 0
    # select next page - should have top
    click_link '11 - 20'
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 4)
    expect(page).to have_css('div.footer-top a.btn-top[href="#"]', text: 'Top')
    expect(page).to have_css('div.footer-top a.btn-top[href="#"] span.glyphicon-arrow-up')
    click_link 'Top'
    page.evaluate_script("$('body.scrollTop()')") == 0
    # should have top link even if total is less than 10
    fill_in 'q', with: 'israel'
    click_button 'search'
    expect(page).to have_css('h2', text: '2 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', maximum: 9)
    expect(page).to have_css('div.footer-top a.btn-top[href="#"]', text: 'Top')
    expect(page).to have_css('div.footer-top a.btn-top[href="#"] span.glyphicon-arrow-up')
    click_link 'Top'
    page.evaluate_script("$('body.scrollTop()')") == 0
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
