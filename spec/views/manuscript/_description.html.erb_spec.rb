require 'rails_helper'

describe 'manuscript/_description.html.erb' do
  include SolrDocumentFixtures
  it 'should render the green navbar and sections with Summary' do
    @document = manuscript_docs[9]
    stub_template 'manuscript/_description/_summary.html.erb' => '<span>summary</span>'
    stub_template 'manuscript/_description/_description.html.erb' => '<span>description</span>'
    render
    expect(rendered).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li', count: 2)
    expect(rendered).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li.active a[href="#summary"]', count: 1, text: 'Summary')
    expect(rendered).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#description"]', count: 1, text: 'Description')
    expect(rendered).to have_css('div.panel-content div.panel-body section#summary')
    expect(rendered).to have_css('div.panel-content div.panel-body section#summary h2', text: 'Summary')
    expect(rendered).to have_css('div.panel-content div.panel-body section#summary span', text: 'summary')
    expect(rendered).to have_css('div.panel-content div.panel-body section#description')
    expect(rendered).to have_css('div.panel-content div.panel-body section#description h2', text: 'Description')
    expect(rendered).to have_css('div.panel-content div.panel-body section#description span', text: 'description')
  end
  it 'should render the green navbar and sections without Summary' do
    @document = manuscript_docs[0]
    stub_template 'manuscript/_description/_description.html.erb' => '<span>description</span>'
    render
    expect(rendered).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li', count: 1)
    expect(rendered).to have_css('nav.navbar-green div.container div.navbar-collapse ul.navbar-nav li a[href="#description"]', count: 1, text: 'Description')
    expect(rendered).to_not have_css('div.panel-content div.panel-body section#summary')
    expect(rendered).to have_css('div.panel-content div.panel-body section#description')
    expect(rendered).to have_css('div.panel-content div.panel-body section#description h2', text: 'Description')
    expect(rendered).to have_css('div.panel-content div.panel-body section#description span', text: 'description')
  end
end
