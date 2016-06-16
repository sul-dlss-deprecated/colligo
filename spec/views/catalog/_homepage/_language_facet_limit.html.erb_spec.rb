require 'spec_helper'

describe '/catalog/_homepage/_language_facet_limit.html.erb' do
  include SolrDocumentFixtures
  let(:f1) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'Latin.', hits: '325') }
  let(:f2) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'Latin', hits: '208') }
  let(:f3) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'Persian', hits: '98') }
  let(:f4) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'Arabic', hits: '61') }
  let(:f5) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'Latin and English.', hits: '30') }
  let(:f6) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'No linguistic content. Not applicable.', hits: '25') }
  let(:f7) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'Greek, Ancient (t0 1453)', hits: '22') }
  let(:f8) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'Latin and Anglo-Norman.', hits: '21') }
  let(:f9) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'Latin and Old English.', hits: '18') }
  let(:f10) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'Old English and Latin.', hits: '14') }
  let(:f11) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'Armenian', hits: '12') }
  let(:f12) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'Geez', hits: '11') }
  let(:f13) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'Middle English and Latin.', hits: '11') }
  let(:f14) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'Turkish, Ottoman (1500-1928)', hits: '11') }
  let(:f15) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'Dutch', hits: '10') }
  let(:f16) { Blacklight::Solr::Response::Facets::FacetItem.new(value: 'English.', hits: '10') }
  let(:lang) do
    [Blacklight::Solr::Response::Facets::FacetField.new(
      'language',
      [f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16],
      options: { sort: 'count', limit: -1 }
    )]
  end
  before(:all) do
    @response = manuscript_resp
  end
  describe 'facet with more link' do
    before(:each) do
      stub_template 'catalog/_homepage/_home_modal.html.erb' => '<div>Home modal partial</div>'
      allow(view).to receive(:blacklight_config).and_return(CatalogController.new.blacklight_config)
      allow(view).to receive(:search_action_path).and_return('/catalog')
      allow(view).to receive(:facet_field).and_return(double('key' => 'language'))
      allow(view).to receive(:facet_field_label).with('language').and_return('Facet label')
      allow(view).to receive(:display_facet).and_return(lang)
      allow(view).to receive(:facet_paginator).and_return(double('total_count' => 8))
      render
    end
    it 'should have an unordered list' do
      expect(rendered).to have_css('ul.facet-values', count: 1)
    end
    it 'should have 5 languages' do
      expect(rendered).to have_css('ul.facet-values a.btn.btn-primary', count: 5)
    end
    it 'should order languages by hits' do
      expect(rendered).to have_selector 'ul.facet-values a:first-child', text: 'Latin.'
      expect(rendered).to have_selector 'ul.facet-values a:nth-child(2)', text: 'Latin'
      expect(rendered).to have_selector 'ul.facet-values a:nth-child(3)', text: 'Persian'
      expect(rendered).to have_selector 'ul.facet-values a:nth-child(4)', text: 'Arabic'
      expect(rendered).to have_selector 'ul.facet-values a:nth-child(5)', text: 'Latin and English.'
    end
    it 'should display more facets link' do
      expect(rendered).to have_css('ul.facet-values button.btn.btn-primary-outline.more_facets_link', count: 1, text: 'More »')
    end
    it 'should render home modal partial' do
      expect(rendered).to have_css('ul.facet-values div', count: 1, text: 'Home modal partial')
    end
  end
  describe 'facet with no more link' do
    before(:each) do
      stub_template 'catalog/_homepage/_home_modal.html.erb' => '<div>Home modal partial</div>'
      allow(view).to receive(:blacklight_config).and_return(CatalogController.new.blacklight_config)
      allow(view).to receive(:search_action_path).and_return('/catalog')
      allow(view).to receive(:facet_field).and_return(double('key' => 'language'))
      allow(view).to receive(:facet_field_label).with('language').and_return('Facet label')
      allow(view).to receive(:display_facet).and_return(lang)
      allow(view).to receive(:facet_paginator).and_return(double('total_count' => 5))
      render
    end
    it 'should have an unordered list' do
      expect(rendered).to have_css('ul.facet-values', count: 1)
    end
    it 'should have 5 languages' do
      expect(rendered).to have_css('ul.facet-values a.btn.btn-primary', count: 5)
    end
    it 'should not display more facets link' do
      expect(rendered).not_to have_css('ul.facet-values button.btn.btn-primary-outline.more_facets_link', count: 1, text: 'More »')
    end
    it 'should render home modal partial' do
      expect(rendered).not_to have_css('ul.facet-values div', count: 1, text: 'Home modal partial')
    end
  end
end
