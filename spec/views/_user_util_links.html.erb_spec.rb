require 'spec_helper'

describe '_user_util_links' do

  let :blacklight_config do
    Blacklight::Configuration.new.configure do |config|
      config.add_nav_action(:bookmark, partial: 'blacklight/nav/bookmark')
      config.add_nav_action(:history, partial: 'blacklight/nav/search_history')
    end
  end

  describe 'render links with no user authentication provider' do
    before(:each) do
      allow(view).to receive(:blacklight_config).and_return(blacklight_config)
      links = raw('<li><a href="/search_history">History</a></li>
<li><a id="bookmarks_nav" href="/bookmarks">Bookmarks <span data-role="bookmark-counter">1</span>)</a></li>')
      allow(view).to receive(:render_nav_actions).and_return(links, 'options')
      allow(view).to receive(:has_user_authentication_provider?).and_return false
      allow(view).to receive(:current_user).and_return 'current_user_name'
      allow(view).to receive(:destroy_user_session_path).and_return '/user/destroy'
      allow(view).to receive(:edit_user_registration_path).and_return '/user/edit'
      allow(view).to receive(:new_user_session_path).and_return '/user/new'
      # allow(view).to receive_message_chain(:current_or_guest_user, :bookmarks, :count).and_return(count)
      render :partial => 'user_util_links'
    end
    it 'should display dropdown button with text' do
      expect(rendered).to have_selector('ul.nav.navbar-nav.navbar-right')
      expect(rendered).to have_selector('ul.nav.navbar-nav.navbar-right li:nth-child(1).dropdown[id="mywork"]')
      expect(rendered).to have_selector('ul.navbar-right li.dropdown a.dropdown-toggle.hidden-xs[data-toggle="dropdown"][role="button"]', text: 'My Work')
      expect(rendered).to have_selector('ul.navbar-right li.dropdown a.dropdown-toggle span.caret', count: 1)
    end
    it 'should display the hamburger menu button' do
      expect(rendered).to have_selector('ul.navbar-right li.dropdown button.navbar-toggle.btn.collapsed[data-toggle="collapse"][data-target="#user-util-collapse"]')
      expect(rendered).to have_selector('ul.navbar-right li.dropdown button.navbar-toggle span.sr-only', text: 'Toggle navigation')
      expect(rendered).to have_selector('ul.navbar-right li.dropdown button.navbar-toggle span.icon-bar', count: 3)
    end
    it 'should display options within the dropdown' do
      expect(rendered).to have_selector('ul.navbar-right li.dropdown ul.dropdown-menu[id="user-util-collapse"]', count: 1)
      expect(rendered).to have_selector('ul.navbar-right li.dropdown ul.dropdown-menu li', count: 3)
      expect(rendered).to have_selector('ul.navbar-right li.dropdown ul.dropdown-menu li:nth-child(1) a[href="/search_history"]', text: 'History')
      expect(rendered).to have_selector('ul.navbar-right li.dropdown ul.dropdown-menu li:nth-child(2) a[href="/bookmarks"]', text: 'Bookmarks')
      expect(rendered).to have_selector('ul.navbar-right li.dropdown ul.dropdown-menu li:nth-child(2) a[href="/bookmarks"] span[data-role="bookmark-counter"]', text: '1')
      expect(rendered).to have_selector('ul.navbar-right li.dropdown ul.dropdown-menu li:nth-child(3).divider[role="separator"]')
      expect(rendered).to have_selector('ul.navbar-right li[id="nav_top"] a span.glyphicon.glyphicon-arrow-up')
    end
  end

end

