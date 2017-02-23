require 'rails_helper'

describe '/shared/_homepage_header_navbar.html.erb' do
  it 'should have a header without a search form' do
    allow(view).to receive(:application_name).and_return('Colligo')
    allow(view).to receive(:root_path).and_return('/')
    allow(view).to receive(:container_classes).and_return('container_classes')
    stub_template '_user_util_links.html.erb' => '<span>User util links</span>'
    render
    expect(rendered).to have_css('div.navbar.navbar-inverse.navbar-fixed-top[id="header-navbar"] div.container_classes div.navbar-header a.navbar-brand', text: 'Colligo')
    expect(rendered).to have_css('div.navbar.navbar-inverse.navbar-fixed-top[id="header-navbar"] div.container_classes div.navbar-header span', text: 'User util links')
  end
end
