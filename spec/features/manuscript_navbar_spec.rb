require 'spec_helper'

describe 'Manuscript nav bar', type: :feature, js: true do
  it 'should have set the acrive navigation element' do
    visit '/manuscript/jr903ng8662'
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li.active a[href="#summary"]', count: 1, text: 'Summary')
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#description"]', count: 1, text: 'Description')
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#contents"]', count: 1, text: 'Contents')
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#bibliography"]', count: 1, text: 'Bibliography')
    click_link 'Description'
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#summary"]', count: 1, text: 'Summary')
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li.active a[href="#description"]', count: 1, text: 'Description')
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#contents"]', count: 1, text: 'Contents')
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#bibliography"]', count: 1, text: 'Bibliography')
    click_link 'Bibliography'
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#summary"]', count: 1, text: 'Summary')
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#description"]', count: 1, text: 'Description')
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#contents"]', count: 1, text: 'Contents')
    expect(page).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li.active a[href="#bibliography"]', count: 1, text: 'Bibliography')
  end
end
