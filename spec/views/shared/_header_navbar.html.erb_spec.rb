require 'spec_helper'

describe '/shared/_header_navbar.html.erb' do
  it 'should have a header without a search form' do
    allow(view).to receive(:application_name).and_return('Colligo')
    allow(view).to receive(:render_search_bar).and_return(raw '<span>Search bar</span>')
    stub_template '_user_util_links.html.erb' => '<span>User util links</span>'
    render
    expect(rendered).to have_css('div#header-navbar div div.navbar-header a.navbar-brand', text: 'Colligo')
    expect(rendered).to have_css('div#header-navbar div div.navbar-header div.searchbar span', text: 'Search bar')
    expect(rendered).to have_css('div#header-navbar div div#user-util-collapse span', text: 'User util links')
  end
end
