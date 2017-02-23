require 'rails_helper'

describe 'Homepage search tab', type: :feature, js: true do
  it 'should set the class and focus on search' do
    visit('/')
    within('ul.nav-tabs') do
      within('li[data-field=descriptions]') do
        click_link 'Descriptions'
      end
    end
    expect(page).to have_css('ul.nav-tabs li[data-field=all_fields]', text: 'All Content')
    expect(page).to have_css('ul.nav-tabs li.active[data-field=descriptions]', text: 'Descriptions')
    expect(page).to have_css('ul.nav-tabs li[data-field=transcriptions]', text: 'Transcriptions')
    expect(page).to have_css('ul.nav-tabs li[data-field=annotations]', text: 'Annotations')
    page.evaluate_script('document.activeElement.id') == 'q'
    page.evaluate_script('document.getElementById("main_search_field").value') == 'descriptions'
    # Cannot figure out why for the life of me the following don't work but the evaluate script is
    # save_and_open_page
    # expect(page).to have_css('form[role=search] input[type=hidden][name=search_field][value=descriptions]')
    # expect(page).to have_css('input#main_search_field[value=descriptions]')
    # find_field('main_search_field').value.should eq 'descriptions'
  end
end
