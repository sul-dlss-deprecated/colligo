require 'spec_helper'

describe 'Search page paginate', type: :feature, js: true do
  it 'should have the pagination options for manuscripts' do
    visit root_path
    click_link 'Descriptions'
    # sleep 2
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    fill_in 'q', with: 'gospel'
    click_button 'search'
    # default pagination
    expect(page).to have_css('h2', text: '62 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.prev-page', text: nil)
    expect(page).to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '1 - 10 of')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: 'results')
    # click on next
    click_link('1 - 10 of')
    expect(page).to have_css('h2', text: '62 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.prev-page a.btn-paginate-prev span.glyphicon-arrow-left')
    expect(page).to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '11 - 20 of')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: 'results')
    # click 20 per page
    click_link('20')
    expect(page).to have_css('h2', text: '62 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 20)
    expect(page).to have_css('div.prev-page', text: nil)
    expect(page).to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '1 - 20 of')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: 'results')
    # click on next
    click_link('1 - 20 of')
    expect(page).to have_css('h2', text: '62 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 20)
    expect(page).to have_css('div.prev-page a.btn-paginate-prev span.glyphicon-arrow-left')
    expect(page).to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '21 - 40 of')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: 'results')
    # click on next
    click_link('21 - 40 of')
    expect(page).to have_css('h2', text: '62 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 20)
    expect(page).to have_css('div.prev-page a.btn-paginate-prev span.glyphicon-arrow-left')
    expect(page).to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '41 - 60 of')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: 'results')
    # click on next
    click_link('41 - 60 of')
    expect(page).to have_css('h2', text: '62 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 2)
    expect(page).to have_css('div.prev-page a.btn-paginate-prev span.glyphicon-arrow-left')
    expect(page).not_to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next span.page_entries', text: '61 - 62 of')
    expect(page).to have_css('a.btn-paginate-next span.page_entries', text: 'results')
    # click on prev
    click_link('previouspage')
    expect(page).to have_css('h2', text: '62 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 20)
    expect(page).to have_css('div.prev-page a.btn-paginate-prev span.glyphicon-arrow-left')
    expect(page).to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '41 - 60 of')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: 'results')
    # should not have pagination options if total is less than 10
    fill_in 'q', with: 'israel'
    click_button 'search'
    expect(page).to have_css('h2', text: '1 Manuscripts')
    expect(page).to have_css('div#content div.search-panel', count: 1)
    expect(page).not_to have_css('div.prev-page')
    expect(page).not_to have_css('a.btn-paginate-next')
  end
  it 'should not have pagination options if no results for manuscripts' do
    visit root_path
    click_link 'Descriptions'
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    fill_in 'q', with: 'foobar'
    click_button 'search'
    expect(page).to have_css('h2', text: '0 Manuscripts')
    expect(page).not_to have_css('div#content div.search-panel')
    expect(page).not_to have_css('div.prev-page')
    expect(page).not_to have_css('a.btn-paginate-next')
  end
  it 'should have the pagination options for transcriptions' do
    visit root_path
    click_link 'Transcriptions'
    # sleep 2
    page.evaluate_script('document.getElementById("main_search_field").value') == 'transcriptions'
    fill_in 'q', with: 'jesus'
    click_button 'search'
    # default pagination
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.prev-page', text: nil)
    expect(page).to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '1 - 10 of')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '24 results')
    # click on next
    click_link('1 - 10 of')
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.prev-page a.btn-paginate-prev span.glyphicon-arrow-left')
    expect(page).to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '11 - 20 of')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '24 results')
    # click on next
    click_link('11 - 20')
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 4)
    expect(page).to have_css('div.prev-page a.btn-paginate-prev span.glyphicon-arrow-left')
    expect(page).not_to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next span.page_entries', text: '21 - 24 of')
    expect(page).to have_css('a.btn-paginate-next span.page_entries', text: '24 results')
    # click on prev
    click_link('previouspage')
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 10)
    expect(page).to have_css('div.prev-page a.btn-paginate-prev span.glyphicon-arrow-left')
    expect(page).to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '11 - 20 of')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '24 results')
    # click on 20
    click_link('20')
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 20)
    expect(page).to have_css('div.prev-page', text: nil)
    expect(page).not_to have_css('div.prev-page a.btn-paginate-prev span.glyphicon-arrow-left')
    expect(page).to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '1 - 20 of')
    expect(page).to have_css('a.btn-paginate-next div span.page_entries', text: '24 results')
    # click on next
    click_link('1 - 20')
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 4)
    expect(page).to have_css('div.prev-page a.btn-paginate-prev span.glyphicon-arrow-left')
    expect(page).not_to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).to have_css('a.btn-paginate-next span.page_entries', text: '21 - 24 of')
    expect(page).to have_css('a.btn-paginate-next span.page_entries', text: '24 results')
    # click on 50
    click_link('50')
    expect(page).to have_css('h2', text: '24 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 24)
    expect(page).not_to have_css('div.prev-page')
    expect(page).not_to have_css('a.btn-paginate-next')
    # should not have pagination options if total is less than 10
    fill_in 'q', with: 'israel'
    click_button 'search'
    expect(page).to have_css('h2', text: '2 Transcriptions')
    expect(page).to have_css('div#content div.search-panel', count: 2)
    expect(page).not_to have_css('div.prev-page')
    expect(page).not_to have_css('a.btn-paginate-next div span.glyphicon-arrow-right')
    expect(page).not_to have_css('a.btn-paginate-next')
  end
  it 'should not have pagination options if no results for manuscripts' do
    visit root_path
    click_link 'Transcriptions'
    page.evaluate_script('document.getElementById("main_search_field").value') == 'transcriptions'
    fill_in 'q', with: 'foobar'
    click_button 'search'
    expect(page).to have_css('h2', text: '0 Transcriptions')
    expect(page).not_to have_css('div#content div.search-panel')
    expect(page).not_to have_css('div.prev-page')
    expect(page).not_to have_css('a.btn-paginate-next')
  end
end
