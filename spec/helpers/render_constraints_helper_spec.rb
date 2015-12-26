require 'spec_helper'

describe RenderConstraintsHelper do
  let(:config) do
    Blacklight::Configuration.new do |config|
      config.add_facet_field 'type'
    end
  end

  before do
    # the helper methods below infer paths from the current route
    controller.request.path_parameters[:controller] = 'catalog'
    allow(helper).to receive(:search_action_path) do |*args|
      root_path *args
    end
    allow(helper).to receive(:label_for_search_field).and_return('Search')
  end

  describe '#query_has_search_constraints?' do
    let(:ans1) { helper.query_has_search_constraints?(q: '') }
    let(:ans2) { helper.query_has_search_constraints?(q: 'foobar') }
    let(:ans3) { helper.query_has_search_constraints?(f: { 'type' => [''] }) }
    it 'should render false for empty query' do
      expect(ans1).to be_false
    end
    it 'should render true for query' do
      expect(ans2).to be_true
    end
    it 'should render false for no query' do
      expect(ans3).to be_false
    end
  end

  describe '#query_has_facet_constraints?' do
    let(:ans1) { helper.query_has_facet_constraints?(f: { 'type' => [], 'model' => [] }) }
    let(:ans2) { helper.query_has_facet_constraints?(f: { 'type' => [], 'model' => [''] }) }
    let(:ans3) { helper.query_has_facet_constraints?(f: { 'type' => ['foo'], 'model' => [''] }) }
    let(:ans4) { helper.query_has_facet_constraints?(f: { 'type' => ['foo'], 'model' => ['bar'] }) }
    let(:ans5) { helper.query_has_facet_constraints?(q: 'foobar') }
    it 'should render false for empty facets' do
      expect(ans1).to be_false
      expect(ans2).to be_false
    end
    it 'should render true for facets' do
      expect(ans3).to be_true
      expect(ans4).to be_true
    end
    it 'should render false for no facets' do
      expect(ans5).to be_false
    end
  end

  describe '#render_simple_constraints_query' do
    let(:my_engine) { double('Engine') }
    it 'should have a link relative to the current url' do
      expect(helper.render_simple_constraints_query(q: 'foobar')).to have_selector('span.filterValue', text: 'foobar')
    end
    it 'should accept an optional route set' do
      expect(helper.render_simple_constraints_query(q: 'foobar', route_set: my_engine)).to have_selector('span.filterValue', text: 'foobar')
    end
  end

  describe '#render_simple_constraints_filters' do
    before do
      allow(helper).to receive(:blacklight_config).and_return(config)
    end
    let(:subject) { helper.render_simple_constraints_filters(f: { 'type' => [''] }) }
    let(:selections) { helper.render_simple_constraints_filters(f: { 'geographic_facet' => ['Great Britain', 'Israel'], 'model' => ['Manuscript'] }) }
    it 'should render nothing for empty facet limit param' do
      expect(subject).to be_blank
    end
    it 'should render facet labels and values' do
      expect(selections).to have_selector('span.filter-geographic_facet span.filterValue', text: 'Great Britain')
      expect(selections).to have_selector('span.filter-geographic_facet span.filterName', text: 'Geographic facet')
      expect(selections).to have_selector('span.filter-geographic_facet span.filterValue', text: 'Israel')
      expect(selections).to have_selector('span.filter-geographic_facet span.filterName', text: 'Geographic facet')
      expect(selections).to have_selector('span.filter-model span.filterValue', text: 'Manuscript')
      expect(selections).to have_selector('span.filter-model span.filterName', text: 'Model')
    end
  end

  describe '#render_simple_filter_element' do
    before do
      allow(helper).to receive(:blacklight_config).and_return(config)
      expect(helper).to receive(:facet_field_label).with('type').and_return('Item Type')
    end
    subject { helper.render_simple_filter_element('type', ['journal'], path) }

    let(:path) { Blacklight::SearchState.new({ q: 'biz' }, config) }

    it 'should have a link relative to the current url' do
      # expect(subject).to have_link 'Remove constraint Item Type: journal', href: '/catalog?q=biz'
      expect(subject).to have_selector '.filterName', text: 'Item Type'
    end
  end
end
