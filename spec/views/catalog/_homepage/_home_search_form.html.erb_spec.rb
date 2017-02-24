require 'rails_helper'

describe '/catalog/_homepage/_home_search_form.html.erb' do
  let(:search_fields) do
    CatalogController.new.blacklight_config.search_fields.map do |sf|
      [sf[1].label, sf[1].key]
    end
  end

  before do
    expect(view).to receive(:search_action_url).and_return('/')
    expect(view).to receive(:search_fields).at_least(:once).and_return(search_fields)
    render
  end

  describe 'it should have search tabs' do
    it 'should have an unordered list with class nav-tab' do
      expect(rendered).to have_css('ul.nav-tabs')
    end
    it 'should have 4 tabs' do
      expect(rendered).to have_css('ul.nav-tabs li', count: 4)
    end
    it 'should have all_fields as the active tab' do
      expect(rendered).to have_css('ul.nav-tabs li.active[data-field=all_fields]', text: 'All Content')
    end
    it 'should have descriptions tab' do
      expect(rendered).to have_css('ul.nav-tabs li[data-field=descriptions]', text: 'Descriptions')
    end
    it 'should have transcriptions tab' do
      expect(rendered).to have_css('ul.nav-tabs li[data-field=transcriptions]', text: 'Transcriptions')
    end
    it 'should have annotations tab' do
      expect(rendered).to have_css('ul.nav-tabs li[data-field=annotations]', text: 'Annotations')
    end
  end

  describe 'it should have a form ' do
    it 'should have a form tag' do
      expect(rendered).to have_css('form[role=search]')
    end
    it 'should have a search field with the value all fields' do
      expect(rendered).to have_css(
        'form[role=search] input[type=hidden][name=search_field][value=all_fields]',
        visible: false
      )
    end
    it 'should have a text field' do
      expect(rendered).to have_css('form[role=search] input[type=text][name=q]')
    end
    it 'should have an input button' do
      expect(rendered).to have_css('form[role=search] button[type=submit]')
      expect(rendered).to have_css('form[role=search] button[type=submit] i.glyphicon-search')
    end
  end
end
