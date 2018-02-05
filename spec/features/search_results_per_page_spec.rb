require 'rails_helper'

describe 'Search page sort', type: :feature, js: true do
  it 'should have the number of results per page option for manuscripts' do
    visit root_path
    click_link 'Descriptions'
    # sleep 2
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    fill_in 'q', with: 'manuscript'
    click_button 'search'
    # default per-page is 10
    expect(page).to have_css('h2', text: '4 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', text: '10')
    expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '20')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '50')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
    # select 50 per-page
    click_link '50'
    expect(page).to have_css('h2', text: '4 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', text: '50')
    expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '10')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '20')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
    # Testing only with test fixtures which has just 3 results
    # select next page
    # click_link '1 - 50'
    # expect(page).to have_css('h2', text: '62 Manuscripts')
    # expect(page).to have_css('div#content div.search-panel', count: 12)
    # expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    # expect(page).to have_css('div.footer-per-page div.page-count span', text: '50')
    # expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    # expect(page).to have_css('div.footer-per-page div.page-count span a', text: '10')
    # expect(page).to have_css('div.footer-per-page div.page-count span a', text: '20')
    # expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
    # # select previous page
    # click_link 'previouspage'
    # expect(page).to have_css('h2', text: '62 Manuscripts')
    # expect(page).to have_css('div#content div.search-panel', count: 50)
    # expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    # expect(page).to have_css('div.footer-per-page div.page-count span', text: '50')
    # expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    # expect(page).to have_css('div.footer-per-page div.page-count span a', text: '10')
    # expect(page).to have_css('div.footer-per-page div.page-count span a', text: '20')
    # expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
    # should have number of search results per page option even if total is less than 10
    fill_in 'q', with: 'gospel'
    click_button 'search'
    expect(page).to have_css('h2', text: '1 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 1)
    expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', text: '10')
    expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '20')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '50')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
  end
  it 'should not have search results per page option if no results for manuscripts' do
    visit root_path
    click_link 'Descriptions'
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    fill_in 'q', with: 'foobar'
    click_button 'search'
    expect(page).to have_css('h2', text: '0 Manuscripts')
    expect(page).not_to have_css('div#content div.search-panel')
    expect(page).not_to have_css('div.footer-per-page')
  end
  it 'should have the number of results per page option for transcriptions' do
    visit root_path
    click_link 'Transcriptions'
    # sleep 2
    page.evaluate_script('document.getElementById("main_search_field").value') == 'transcriptions'
    fill_in 'q', with: 'jesus'
    click_button 'search'
    # default per-page is 10
    # save_and_open_page
    expect(page).to have_selector('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', text: '10')
    expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '20')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '50')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
    # select next page
    click_link '1 - 10'
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', text: '10')
    expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '20')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '50')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
    # select next page
    click_link '11 - 20'
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', text: '10')
    expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '20')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '50')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
    # select previous page
    click_link 'previouspage'
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', text: '10')
    expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '20')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '50')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
    # select 20 per-page
    within '.footer-per-page' do
      click_link('20')
    end
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 20)
    expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', text: '20')
    expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '10')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '50')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
    # select next page
    click_link '1 - 20'
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', text: '20')
    expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '10')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '50')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
    # select previous page
    click_link 'previouspage'
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 20)
    expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', text: '20')
    expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '10')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '50')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
    # should have number of search results per page option even if total is less than 10
    fill_in 'q', with: 'israel'
    click_button 'search'
    expect(page).to have_css('h2', text: '2 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 2)
    expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', text: '10')
    expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '20')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '50')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
  end
  it 'should not have search results per page option if no results for transcriptions' do
    visit root_path
    click_link 'Transcriptions'
    page.evaluate_script('document.getElementById("main_search_field").value') == 'transcriptions'
    fill_in 'q', with: 'foobar'
    click_button 'search'
    expect(page).to have_css('h2', text: '0 Transcriptions')
    expect(page).not_to have_css('div#content div.search-panel')
    expect(page).not_to have_css('div.footer-per-page')
  end
end
