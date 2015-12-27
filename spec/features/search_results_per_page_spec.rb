require 'spec_helper'

describe 'Search page sort', type: :feature, js: true do
  it 'should have the number of search results per page option' do
    visit root_path
    click_link 'Descriptions'
    # sleep 2
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    fill_in 'q', with: 'gospel'
    click_button 'search'
    # default per-page is 10
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', text: '10')
    expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '20')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '50')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
    # select 20 per-page
    click_link '20'
    expect(page).to have_css('div#content div.search-panel', count: 20)
    expect(page).to have_css('div.footer-per-page div.page-count span', count: 4)
    expect(page).to have_css('div.footer-per-page div.page-count span', text: '20')
    expect(page).to have_css('div.footer-per-page div.page-count span a', count: 3)
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '10')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '50')
    expect(page).to have_css('div.footer-per-page div.page-count span a', text: '100')
  end
end
