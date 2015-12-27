require 'spec_helper'

describe 'Search page paginate', type: :feature, js: true do
  it 'should have the pagination options' do
    visit root_path
    click_link 'Descriptions'
    # sleep 2
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    fill_in 'q', with: 'gospel'
    click_button 'search'
    # default pagination
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.prev-page', text: nil)
    expect(page).to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '1 - 10 of')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: 'results')
    # click on next
    click_link('1 - 10 of')
    expect(page).to have_css('div.prev-page a.btn-paginate-prev span.glyphicon-arrow-left')
    expect(page).to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '11 - 20 of')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: 'results')
    # click on prev
    click_link('previouspage')
    expect(page).to have_css('div.prev-page', text: nil)
    expect(page).to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '1 - 10 of')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: 'results')
  end
end
