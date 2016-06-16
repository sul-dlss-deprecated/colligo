require 'spec_helper'

describe 'Manuscript nav bar', type: :feature, js: true do
  it 'should have set the active navigation element' do
    visit '/manuscript/jr903ng8662'
    # save_and_open_page
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li.active a[href="#summary"]', count: 1, text: 'Summary')
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#description"]', count: 1, text: 'Description')
    click_link 'Description'
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#summary"]', count: 1, text: 'Summary')
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li.active a[href="#description"]', count: 1, text: 'Description')
  end
end
