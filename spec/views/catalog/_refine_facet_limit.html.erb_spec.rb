require 'spec_helper'

describe '/catalog/_refine_facet_limit.html.erb' do
  let(:f1) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Latin.', hits: '325') }
  let(:f2) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Latin', hits: '208') }
  let(:f3) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Persian', hits: '98') }
  let(:f4) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Arabic', hits: '61') }
  let(:f5) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Latin and English.', hits: '30') }
  let(:f6) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'No linguistic content. Not applicable.', hits: '25') }
  let(:f7) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Greek, Ancient (t0 1453)', hits: '22') }
  let(:f8) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Latin and Anglo-Norman.', hits: '21') }
  let(:f9) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Latin and Old English.', hits: '18') }
  let(:f10) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Old English and Latin.', hits: '14') }
  let(:f11) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Armenian', hits: '12') }
  let(:f12) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Geez', hits: '11') }
  let(:f13) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Middle English and Latin.', hits: '11') }
  let(:f14) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Turkish, Ottoman (1500-1928)', hits: '11') }
  let(:f15) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Dutch', hits: '10') }
  let(:f16) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'English.', hits: '10') }
  let(:lang) do
    [Blacklight::Solr::Response::Facets::FacetField.new(
        'language',
        [f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16],
        options: {sort: 'count', limit: -1}
    )]
  end
  before(:each) do
    allow(view).to receive(:tab_classes).and_return('tab_class')
    allow(view).to receive(:facet_id).and_return('facet_id')
    allow(view).to receive(:facet_field).and_return(double('key' => 'language'))
    allow(view).to receive(:display_facet).and_return(lang)
    allow(view).to receive(:field_name).and_return('language')
    allow(view).to receive(:facet_paginator).and_return(double('total_count' => 8))
    allow(view).to receive(:render_refine_facet_limit_list).and_return(raw('<div class="refine_facet_limit_list">Refine facet limit list</div>'))
    render
  end
  it 'should have a tab pane' do
    expect(rendered).to have_css('div.tab_class', count: 1)
  end
  it 'should have a search bar label' do
    expect(rendered).to have_css('div.tab-pane div label.lookup-label', count: 1, text: 'Search list')
  end
  it 'should have a search glyphicon' do
    expect(rendered).to have_css('div.tab-pane div div.inner-addon i.glyphicon-search', count: 1)
  end
  it 'should have a search bar' do
    expect(rendered).to have_css('div.tab-pane div div.inner-addon input.form-control', count: 1)
  end
  it 'should have a list for autocomplete' do
    expect(rendered).to have_css('div.tab-pane div div.inner-addon div#facet_id-popover-div ul', count: 1)
  end
  it 'should have a table for facet items' do
    expect(rendered).to have_css('div.tab_class table.tablesorter', count: 1)
  end
  it 'should have table headers for facet items' do
    expect(rendered).to have_css('div.tab_class table.tablesorter thead', count: 1)
    expect(rendered).to have_css('div.tab_class table.tablesorter thead tr', count: 1)
    expect(rendered).to have_css('div.tab_class table.tablesorter thead tr th', count: 2)
    expect(rendered).to have_selector 'table.tablesorter thead tr th:first-child', text: 'Value'
    expect(rendered).to have_selector 'table.tablesorter thead tr th:nth-child(2)', text: 'Count'
  end
  it 'should have table body' do
    expect(rendered).to have_css('div.tab_class table.tablesorter tbody', count: 1)
  end
  it 'should render refine facet limit list' do
    expect(rendered).to have_css('div.tab_class table.tablesorter tbody div.refine_facet_limit_list', count: 1, text: 'Refine facet limit list')
  end
end