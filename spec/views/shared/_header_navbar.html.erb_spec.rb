require 'rails_helper'

describe '/shared/_header_navbar.html.erb' do
  it 'should have a header with a search form' do
    allow(view).to receive(:application_name).and_return('Colligo')
    allow(view).to receive(:root_path).and_return('/')
    allow(view).to receive(:container_classes).and_return('container_classes')
    allow(view).to receive(:render_search_bar).and_return(raw('<span>Search bar</span>'))
    stub_template '_user_util_links.html.erb' => '<span>User util links</span>'
    render
    expect(rendered).to have_css('div.navbar.navbar-inverse.navbar-fixed-top[id="header-navbar"] div.container_classes div.navbar-header a.navbar-brand', text: 'Colligo')
    # search bar for all forms other than the smallest form factor
    expect(rendered).to have_css('div.navbar.navbar-inverse.navbar-fixed-top[id="header-navbar"] div.container_classes div.navbar-header div.searchbar.hidden-xs span', text: 'Search bar')
    expect(rendered).to have_css('div.navbar.navbar-inverse.navbar-fixed-top[id="header-navbar"] div.container_classes div.navbar-header span', text: 'User util links')
    # search bar for the smallest form factor
    expect(rendered).to have_css('div.navbar.navbar-inverse.navbar-fixed-top[id="header-navbar"] div.container_classes div.navbar-header div.searchbar.hidden-sm.hidden-md.hidden-lg span', text: 'Search bar')
  end
end
