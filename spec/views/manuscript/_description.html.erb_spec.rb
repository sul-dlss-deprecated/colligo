require 'spec_helper'

describe 'manuscript/_description.html.erb' do
  it 'should render the green navbar and sections' do
    stub_template 'manuscript/_description/_summary.html.erb' => '<span>summary</span>'
    stub_template 'manuscript/_description/_description.html.erb' => '<span>description</span>'
    stub_template 'manuscript/_description/_contents.html.erb' => '<span>contents</span>'
    render
    expect(rendered).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li', count: 4)
    expect(rendered).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li.active a[href="#summary"]', count: 1, text: 'Summary')
    expect(rendered).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#description"]', count: 1, text: 'Description')
    expect(rendered).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#contents"]', count: 1, text: 'Contents')
    expect(rendered).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#bibliography"]', count: 1, text: 'Bibliography')
    expect(rendered).to have_css('div.panel-content div.panel-body section#summary')
    expect(rendered).to have_css('div.panel-content div.panel-body section#summary h2', text: 'Summary')
    expect(rendered).to have_css('div.panel-content div.panel-body section#summary span', text: 'summary')
    expect(rendered).to have_css('div.panel-content div.panel-body section#description')
    expect(rendered).to have_css('div.panel-content div.panel-body section#description h2', text: 'Description')
    expect(rendered).to have_css('div.panel-content div.panel-body section#description span', text: 'description')
    expect(rendered).to have_css('div.panel-content div.panel-body section#contents')
    expect(rendered).to have_css('div.panel-content div.panel-body section#contents h2', text: 'Contents')
    expect(rendered).to have_css('div.panel-content div.panel-body section#contents span', text: 'contents')
    expect(rendered).to have_css('div.panel-content div.panel-body section#bibliography')
    expect(rendered).to have_css('div.panel-content div.panel-body section#bibliography h2', text: 'Bibliography')
  end
end
