require 'rails_helper'

describe 'shared/_bookmark_control.html.erb' do
  describe 'document is not bookmarked' do
    before(:each) do
      allow(view).to receive(:document).and_return(double(id: 'hp146pz7537'))
      allow(view).to receive(:current_or_guest_user).and_return(true)
      allow(view).to receive(:bookmarked?).and_return(false)
      allow(view).to receive(:bookmark_path).and_return('/bookmark/hp146pz7537')
      render
    end
    it 'should have a form' do
      expect(rendered).to have_css('form.bookmark_toggle.pull-right[method="post"][action="/bookmark/hp146pz7537"]')
    end
    it 'should have form method as put' do
      expect(rendered).to have_css(
        'form.bookmark_toggle.pull-right input[type="hidden"][name="_method"][value="put"]',
        visible: false
      )
    end
    it 'should display a button with a glyphicon' do
      expect(rendered).to have_css('form.bookmark_toggle button.bookmark_add[id="bookmark_toggle_hp146pz7537"]', text: 'bookmark')
      expect(rendered).to have_css('form.bookmark_toggle button.bookmark_add[id="bookmark_toggle_hp146pz7537"] span.glyphicon-bookmark')
    end
  end
  describe 'document is bookmarked' do
    before(:each) do
      allow(view).to receive(:document).and_return(double(id: 'hp146pz7537'))
      allow(view).to receive(:current_or_guest_user).and_return(true)
      allow(view).to receive(:bookmarked?).and_return(true)
      allow(view).to receive(:bookmark_path).and_return('/bookmark/hp146pz7537')
      render
    end
    it 'should have a form' do
      expect(rendered).to have_css('form.bookmark_toggle.pull-right[method="post"][action="/bookmark/hp146pz7537"]')
    end
    it 'should have form method as delete' do
      expect(rendered).to have_css(
        'form.bookmark_toggle.pull-right input[type="hidden"][name="_method"][value="delete"]',
        visible: false
      )
    end
    it 'should display a button with a glyphicon' do
      expect(rendered).to have_css('form.bookmark_toggle button.bookmark_remove[id="bookmark_toggle_hp146pz7537"]', text: 'bookmarked')
      expect(rendered).to have_css('form.bookmark_toggle button.bookmark_remove[id="bookmark_toggle_hp146pz7537"] span.glyphicon-bookmark')
    end
  end
end
