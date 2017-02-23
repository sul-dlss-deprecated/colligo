require 'rails_helper'

describe '/catalog/_refine_facets.html.erb' do
  describe 'facet limits with facet constraints in query' do
    before(:each) do
      allow(view).to receive(:has_facet_values?).and_return(true)
      allow(view).to receive(:params).and_return(double(f: { language: ['Latin'] }))
      allow(view).to receive(:query_has_facet_constraints?).and_return(true)
      allow(view).to receive(:render_clear_all).and_return(raw('<div class="clear_all">Clear all</div>'))
      allow(view).to receive(:render_facet_tabs).and_return(raw('<div class="facet_tabs">Facet tabs</div>'))
      allow(view).to receive(:render_refine_facet_partials).and_return(raw('<div class="refine_facet_partials">Refine facet partials</div>'))
      render
    end
    it 'should display a dropdown div' do
      expect(rendered).to have_css('div.dropdown', count: 1)
    end
    it 'should display a dropdown label' do
      expect(rendered).to have_selector 'div.dropdown a#dLabel h4', count: 1, text: 'Refine'
      expect(rendered).to have_selector 'div.dropdown a#dLabel h4 span.caret', count: 1
    end
    it 'should have a dropdown body' do
      expect(rendered).to have_selector 'div.dropdown ul#myTabs', count: 1
      expect(rendered).to have_selector 'div.dropdown ul.dropdown-menu', count: 1
    end
    it 'should have left column for tabs displaying available facets' do
      expect(rendered).to have_selector 'ul#myTabs div.row div.col-xs-3', count: 1
    end
    it 'should have right column for table with facet contents' do
      expect(rendered).to have_selector 'ul#myTabs div.row div.col-xs-9', count: 1
    end
    it 'should have spacing below' do
      expect(rendered).to have_selector 'ul#myTabs div.row div.clearfix', count: 1
    end
    it 'should render clear all in left column' do
      expect(rendered).to have_selector 'ul#myTabs div.row div.col-xs-3 div div.clear_all', count: 1, text: 'Clear all'
    end
    it 'should render tabs in left column' do
      expect(rendered).to have_selector 'ul#myTabs div.row div.col-xs-3 ul.nav.nav-tabs.tabs-left div.facet_tabs', count: 1, text: 'Facet tabs'
    end
    it 'should render facet contents in right column' do
      expect(rendered).to have_selector 'ul#myTabs div.row div.col-xs-9 div.tab-content div.refine_facet_partials', count: 1, text: 'Refine facet partials'
    end
  end
  describe 'facet limits without any facet constraints in query' do
    before(:each) do
      allow(view).to receive(:has_facet_values?).and_return(true)
      allow(view).to receive(:params).and_return(double(f: { language: [] }))
      allow(view).to receive(:query_has_facet_constraints?).and_return(false)
      allow(view).to receive(:render_clear_all).and_return(raw('<div class="clear_all">Clear all</div>'))
      allow(view).to receive(:render_facet_tabs).and_return(raw('<div class="facet_tabs">Facet tabs</div>'))
      allow(view).to receive(:render_refine_facet_partials).and_return(raw('<div class="refine_facet_partials">Refine facet partials</div>'))
      render
    end
    it 'should not render clear all in left column' do
      expect(rendered).not_to have_selector 'ul#myTabs div.row div.col-xs-3 div div.clear_all', count: 1, text: 'Clear all'
    end
    it 'should render tabs in left column' do
      expect(rendered).to have_selector 'ul#myTabs div.row div.col-xs-3 ul.nav.nav-tabs.tabs-left div.facet_tabs', count: 1, text: 'Facet tabs'
    end
    it 'should render facet contents in right column' do
      expect(rendered).to have_selector 'ul#myTabs div.row div.col-xs-9 div.tab-content div.refine_facet_partials', count: 1, text: 'Refine facet partials'
    end
  end
end
