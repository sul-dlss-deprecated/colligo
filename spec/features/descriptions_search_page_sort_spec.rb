require 'rails_helper'

describe 'Search page sort', type: :feature, js: true do
  it 'should have the search options' do
    visit root_path
    click_link 'Descriptions'
    # sleep 2
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    fill_in 'q', with: 'gospel'
    click_button 'search'
    # default sort is relevance
    expect(page).to have_css('div#sort-dropdown button', text: 'Sorted by')
    expect(page).to have_css('div#sort-dropdown button span', text: 'relevance')
    expect(page).to have_content('Sorted byrelevance')
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:first-child').text()") == 'relevance'
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:nth-child(2)').text()") == 'title'
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:nth-child(2)').text()") == 'century'
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:last-child').text()") == 'repository'
    # sort by title
    click_button 'Sorted by'
    click_link 'title'
    expect(page).to have_css('div#sort-dropdown button', text: 'Sorted by')
    expect(page).to have_css('div#sort-dropdown button span', text: 'title')
    expect(page).to have_content('Sorted bytitle')
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:first-child').text()") == 'relevance'
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:nth-child(2)').text()") == 'title'
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:nth-child(2)').text()") == 'century'
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:last-child').text()") == 'repository'
    # sort by century
    click_button 'Sorted by'
    click_link 'century'
    expect(page).to have_css('div#sort-dropdown button', text: 'Sorted by')
    expect(page).to have_css('div#sort-dropdown button span', text: 'century')
    expect(page).to have_content('Sorted bycentury')
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:first-child').text()") == 'relevance'
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:nth-child(2)').text()") == 'title'
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:nth-child(2)').text()") == 'century'
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:last-child').text()") == 'repository'
    # sort by repository
    click_button 'Sorted by'
    click_link 'repository'
    expect(page).to have_css('div#sort-dropdown button', text: 'Sorted by')
    expect(page).to have_css('div#sort-dropdown button span', text: 'repository')
    expect(page).to have_content('Sorted byrepository')
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:first-child').text()") == 'relevance'
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:nth-child(2)').text()") == 'title'
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:nth-child(2)').text()") == 'century'
    page.evaluate_script("$('#sort-dropdown ul.dropdown-menu:last-child').text()") == 'repository'
    # sort by relevance
    click_button 'Sorted by'
    click_link 'relevance'
    expect(page).to have_css('div#sort-dropdown button', text: 'Sorted by')
    expect(page).to have_css('div#sort-dropdown button span', text: 'relevance')
    expect(page).to have_content('Sorted byrelevance')
  end
end
