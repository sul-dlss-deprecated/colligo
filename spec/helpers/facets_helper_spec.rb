require 'spec_helper'

# require 'equivalent-xml'

describe FacetsHelper do
  let(:blacklight_config) { Blacklight::Configuration.new }

  before(:each) do
    allow(helper).to receive(:blacklight_config).and_return blacklight_config
  end
  
  describe 'render_refine_facet_partials' do
    it 'should try to render all provided facets ' do
      a = double(:items => [1,2])
      b = double(:items => ['b','c'])
      empty = double(:items => [])

      fields = [a,b,empty]

      allow(helper).to receive(:render_refine_facet_limit).with(a, {})
      allow(helper).to receive(:render_refine_facet_limit).with(b, {})
      allow(helper).to receive(:render_refine_facet_limit).with(empty, {})

      helper.render_refine_facet_partials fields
    end

    it 'should default to the configured facets' do
      a = double(:items => [1,2])
      b = double(:items => ['b','c'])
      allow(helper).to receive(:facet_field_names) { [a,b] }

      allow(helper).to receive(:render_refine_facet_limit).with(a, {})
      allow(helper).to receive(:render_refine_facet_limit).with(b, {})

      helper.render_refine_facet_partials
    end

  end

  describe 'render_facet_tabs' do
    it 'is a pending test'

    # it 'should try to render tabs for all provided facets' do
    #   # Test fails with ArgumentError: comparison of Symbol with 0 failed
    #   a = double(name: 'Authors', items: [1,2])
    #   b = double(name: 'Language', items: ['b','c'])
    #   empty = double(name: 'Topic', items: [])
    #   fields = [a, b, empty]
    #   c = allow(helper).to receive(:facet_configuration_for_field).with(a.name).and_return
    #   d = allow(helper).to receive(:facet_configuration_for_field).with(b.name).and_return
    #   e = allow(helper).to receive(:facet_configuration_for_field).with(empty.name).and_return
    #   allow(helper).to receive(:render_facet_tab).with(c, hash_including(locals: hash_including(index: 0)))
    #   allow(helper).to receive(:render_facet_tab).with(d, hash_including(locals: hash_including(index: 1)))
    #   allow(helper).to receive(:render_facet_tab).with(e, hash_including(locals: hash_including(index: 2)))
    #
    #   helper.render_facet_tabs fields
    # end

    it 'should default to the configured facets' do
      a = double(name: 'Authors', items: [1,2])
      b = double(name: 'Language', items: ['b','c'])
      empty = double(name: 'Topic', items: [])

      c = allow(helper).to receive(:facet_configuration_for_field).with(a.name).and_return
      d = allow(helper).to receive(:facet_configuration_for_field).with(b.name).and_return
      e = allow(helper).to receive(:facet_configuration_for_field).with(empty.name).and_return
      allow(helper).to receive(:render_facet_tab).with(c, hash_including(locals: hash_including(index: 1)))
      allow(helper).to receive(:render_facet_tab).with(d, hash_including(locals: hash_including(index: 1)))
      allow(helper).to receive(:render_facet_tab).with(e, hash_including(locals: hash_including(index: 2)))

      helper.render_facet_tabs
    end

  end

  describe 'render_facet_tab' do

    it 'should try to render an active tab' do
      a = {'label' => 'Authors'}
      option = {locals: {index: 0}}
      allow(helper).to receive(:facet_field_id).with(a).and_return('a_id')
      expected_html = '<li class="active" data-tab-id="a_id"><a href="#a_id" class="disabled" data-toggle="tab">Authors</a></li>'
      result = helper.render_facet_tab(a, option)
      expect(result).to eq(expected_html)
    end

    it 'should try to render a tab' do
      a = {'label' => 'Authors'}
      option = {locals: {index: 2}}
      allow(helper).to receive(:facet_field_id).with(a).and_return('a_id')
      expected_html = '<li class="" data-tab-id="a_id"><a href="#a_id" class="disabled" data-toggle="tab">Authors</a></li>'
      result = helper.render_facet_tab(a, option)
      expect(result).to eq(expected_html)
    end

  end

  describe 'render_refine_facet_limit' do
    before do

      @config = Blacklight::Configuration.new do |config|
        config.add_facet_field 'basic_field'
        config.add_facet_field 'pivot_facet_field', :pivot => ['a', 'b']
        config.add_facet_field 'my_pivot_facet_field_with_custom_partial', :partial => 'custom_facet_partial', :pivot => ['a', 'b']
        config.add_facet_field 'my_facet_field_with_custom_partial', :partial => 'custom_facet_partial'
      end

      # allow(helper).to receive_messages(:blacklight_config => @config)
      allow(helper).to receive(:blacklight_config).and_return @config
      @response = double()
    end

    it 'should set basic local variables' do
      @mock_facet = double(name: 'basic_field', items: [1, 2, 3])
      allow(helper).to receive(:render).with(hash_including(partial: 'refine_facet_limit',
                                                            layout: 'refine_facet_layout',
                                                            locals: {
                                                              field_name: 'basic_field',
                                                              solr_field: 'basic_field',
                                                              facet_field: helper.blacklight_config.facet_fields['basic_field'],
                                                              display_facet: @mock_facet,
                                                              facet_id: 'facet-basic_field',
                                                              tab_classes: ''}
                                                          ))
      helper.render_refine_facet_limit(@mock_facet)
    end

    it 'should render a facet _not_ declared in the configuration' do
      @mock_facet = double(name: 'asdf', items: [1, 2, 3])
      allow(helper).to receive(:render).with(hash_including(partial: 'refine_facet_limit'))
      helper.render_refine_facet_limit(@mock_facet)
    end

    it 'should allow the caller to set the facet partial' do
      @mock_facet = double(name: 'my_facet_field_with_custom_partial', items: [1, 2, 3])
      allow(helper).to receive(:render).with(hash_including(partial: 'custom_facet_partial'))
      helper.render_refine_facet_limit(@mock_facet, partial: 'custom_facet_partial')
    end

    it 'should use a partial layout for rendering the facet frame' do
      @mock_facet = double(name: 'my_facet_field_with_custom_partial', items: [1, 2, 3])
      allow(helper).to receive(:render).with(hash_including(layout: 'refine_facet_layout'))
      helper.render_refine_facet_limit(@mock_facet)
    end

    it 'should allow the caller to opt-out of facet layouts' do
      @mock_facet = double(name: 'my_facet_field_with_custom_partial', items: [1, 2, 3])
      allow(helper).to receive(:render).with(hash_including(layout: nil))
      helper.render_refine_facet_limit(@mock_facet, layout: nil)
    end

    it 'should allow the caller to set the facet layout' do
      @mock_facet = double(name: 'my_facet_field', items: [1, 2, 3])
      allow(helper).to receive(:render).with(hash_including(layout: 'custom_facet_layout'))
      helper.render_refine_facet_limit(@mock_facet, layout: 'custom_facet_layout')
    end

  end

  describe 'render_refine_facet_limit_list' do
    let(:f1) { Blacklight::Solr::Response::Facets::FacetItem.new(hits: '792', value: 'Book') }
    let(:f2) { Blacklight::Solr::Response::Facets::FacetItem.new(hits: '65', value: 'Musical Score') }
    let(:paginator) { Blacklight::Solr::FacetPaginator.new([f1, f2], limit: 10) }
    subject { helper.render_refine_facet_limit_list(paginator, 'type_solr_field') }
    before do
      allow(helper).to receive(:search_action_path) do |*args|
        catalog_index_path *args
      end
    end
    it 'should draw a list of elements' do
      expect(subject).to have_selector 'tr', count: 2
      expect(subject).to have_selector 'tr:first-child td.facet-label', text: 'Book'
      expect(subject).to have_selector 'tr:nth-child(2) td.facet-label', text: 'Musical Score'
    end
  end

  describe 'render_refine_facet_item' do
    let(:f1) { Blacklight::Solr::Response::Facets::FacetItem.new(hits: '792', value: 'Book') }
    let(:f2) { Blacklight::Solr::Response::Facets::FacetItem.new(hits: '65', value: 'Musical Score') }
    before do
      allow(helper).to receive(:search_action_path) do |*args|
        catalog_index_path *args
      end
    end
    describe 'render selected facet item' do
      subject { helper.render_refine_facet_item('type_solr_field', f1) }
      before do
        allow(helper).to receive(:facet_in_params?).and_return(true)
      end
      it 'should draw a row for the select param ' do
        expect(subject).to have_selector 'td', count: 2
        expect(subject).to have_selector 'td:first-child span.selected', text: 'Book'
        expect(subject).to have_selector 'td:nth-child(2).selected.facet-count', text: '792'
      end
    end
    describe 'render normal facet item' do
      subject { helper.render_refine_facet_item('type_solr_field', f2) }
      before do
        allow(helper).to receive(:facet_in_params?).and_return(false)
      end
      it 'should draw a row for the select param ' do
        expect(subject).to have_selector 'td', count: 2
        expect(subject).to have_selector 'td:first-child', text: 'Musical Score'
        expect(subject).to have_selector 'td:nth-child(2).facet-count', text: '65'
      end
    end
  end

  describe 'render_refine_facet_value' do
    let (:item) { double(value: 'A', hits: 10) }
    before do
      allow(helper).to receive(:facet_configuration_for_field).with('simple_field').and_return(
          double(query: nil, date: nil, helper_method: nil, single: false, url_method: nil))
      allow(helper).to receive(:facet_display_value).and_return('Z')
      allow(helper).to receive(:add_facet_params_and_redirect).and_return({controller:'catalog'})

      allow(helper).to receive(:search_action_path) do |*args|
        catalog_index_path *args
      end
    end
    describe 'simple case' do
      let(:expected_html) { '<td class="facet-label"><a class="facet_select" href="/catalog">Z</a></td><td class="facet-count">10</td>' }
      it 'should use facet_display_value' do
        result = helper.render_refine_facet_value('simple_field', item)
        expect(result).to eq(expected_html)
      end
    end

    describe 'when :url_method is set' do
      let(:expected_html) { '<td class="facet-label"><a class="facet_select" href="/blabla">Z</a></td><td class="facet-count">10</td>' }
      it 'should use that method' do
        allow(helper).to receive(:facet_configuration_for_field).with('simple_field').and_return(double(:query => nil,
                                  :date => nil, :helper_method => nil, :single => false, :url_method => :test_method))
        allow(helper).to receive(:test_method).with('simple_field', item).and_return('/blabla')
        result = helper.render_refine_facet_value('simple_field', item)
        expect(result).to eq(expected_html)
      end
    end

    describe 'when :suppress_link is set' do
      let(:expected_html) { '<td class="facet-label">Z</td><td class="facet-count">10</td>' }
      it 'should suppress the link' do
        result = helper.render_refine_facet_value('simple_field', item, :suppress_link => true)
        expect(result).to eq(expected_html)
      end
    end
  end

  describe 'render_refine_selected_facet_value' do
    let (:item) { double(value: 'A', hits: 10) }
    let(:expected_html) { '<td class="facet-label"><span class="selected">Z</span><a class="remove" href="/catalog"><span class="glyphicon glyphicon-remove"></span><span class="sr-only">[remove]</span></a></td><td class="selected facet-count">10</td>' }
    before do
      allow(helper).to receive(:facet_configuration_for_field).with('simple_field').and_return(
          double(query: nil, date: nil, helper_method: nil, single: false, url_method: nil))
      allow(helper).to receive(:facet_display_value).and_return('Z')
      allow(helper).to receive(:remove_facet_params).and_return({})
      allow(helper).to receive(:search_action_path) do |*args|
        catalog_index_path *args
      end
    end
    it 'should use facet_display_value' do
      result = helper.render_refine_selected_facet_value('simple_field', item)
      expect(result).to eq(expected_html)
    end
  end

end
