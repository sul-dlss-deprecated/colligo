require 'spec_helper'

describe '/catalog/_homepage/_century.html.erb' do
  before(:each) do
    allow(view).to receive(:blacklight_config).and_return(CatalogController.new.blacklight_config)
    render
  end

  it 'should render headings' do
    rendered.should match('<h3.*?>by century</h3>')
  end

  describe 'div tag for slider' do
    it 'should have a div tag' do
      expect(rendered).to have_css('div#century_slider')
    end
    it 'should have a boundaries data attribute' do
      expect(rendered).to have_css('div#century_slider[data-boundaries]')
    end
    it 'should have a ticks data attribute' do
      expect(rendered).to have_css('div#century_slider[data-ticks]')
    end
  end

  describe 'div tag for flot bar chart' do
    it 'should have a div tag' do
      expect(rendered).to have_css('div#century_panel')
    end
    it 'should have a rawdata data attribute' do
      expect(rendered).to have_css('div#century_panel[data-rawdata]')
    end
    it 'should have a ticks data attribute' do
      expect(rendered).to have_css('div#century_panel[data-ticks]')
    end
    it 'should have a pointer lookup data attribute' do
      expect(rendered).to have_css('div#century_panel[data-pointerlookup]')
    end
  end
  describe 'form for century' do
    it 'should have a form tag' do
      expect(rendered).to have_css('form.range_limit')
      expect(rendered).to have_css('form.range_limit input#range_pub_date_t_begin')
      expect(rendered).to have_css('form.range_limit input#range_pub_date_t_end')
      expect(rendered).to have_css('form.range_limit input#search_descriptions_century[type=hidden][value=descriptions]')
    end
  end
end