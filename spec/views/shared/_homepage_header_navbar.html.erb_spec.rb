require 'spec_helper'

describe '/shared/_homepage_header_navbar.html.erb' do
  it 'should have a header without a search form' do
    allow(view).to receive(:application_name).and_return('Colligo')
    # allow(view).to receive(:blacklight_config).and_return(CatalogController.new.blacklight_config)
    # allow(view).to receive(:has_user_authentication_provider?).and_return('true')
    stub_template '_user_util_links.html.erb' => '<span>User util links</span>'
    render
    expect(rendered).to have_css('div#header-navbar div div.navbar-header a.navbar-brand', text: 'Colligo')
    expect(rendered).to have_css('div#header-navbar div div#user-util-collapse span', text: 'User util links')
  end
end
