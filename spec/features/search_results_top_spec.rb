require 'spec_helper'

describe 'Search page top', type: :feature, js: true do
  it 'should have the top link' do
    visit root_path
    click_link 'Descriptions'
    # sleep 2
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    fill_in 'q', with: 'gospel'
    click_button 'search'
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.footer-top a.btn-top[href="#"]', text: 'Top')
    expect(page).to have_css('div.footer-top a.btn-top[href="#"] span.glyphicon-arrow-up')
    click_link 'Top'
    page.evaluate_script("$('body.scrollTop()')") == 0
  end
end
