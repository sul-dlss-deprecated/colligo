require 'spec_helper'

describe CatalogController do
  describe '#index home page' do
    before do
      allow(controller).to receive(:on_home_page).and_return(true)
      get :index
    end
    it 'should add range facet if on home page' do
      expect(controller.blacklight_config.facet_fields).to have_key('pub_date_t')
    end
    it 'should have manuscripts' do
      expect(controller.instance_variable_get('@response_m')).not_to be_nil
    end
    it 'should have annotations' do
      expect(controller.instance_variable_get('@response_a')).not_to be_nil
    end
    it 'should not have transcriptions' do
      expect(controller.instance_variable_get('@response_t')).to be_nil
    end
    it 'should have plot data' do
      expect(controller.instance_variable_get('@data_array')).not_to be_nil
      expect(controller.instance_variable_get('@data_array')).to be_a Array
      expect(controller.instance_variable_get('@data_ticks')).not_to be_nil
      expect(controller.instance_variable_get('@data_ticks')).to be_a Array
      expect(controller.instance_variable_get('@pointer_lookup')).not_to be_nil
      expect(controller.instance_variable_get('@pointer_lookup')).to be_a Array
      expect(controller.instance_variable_get('@slider_ticks')).not_to be_nil
      expect(controller.instance_variable_get('@slider_ticks')).to be_a Array
      expect(controller.instance_variable_get('@boundaries')).not_to be_nil
      expect(controller.instance_variable_get('@boundaries')).to be_a Array
      expect(controller.instance_variable_get('@boundaries').length).to eq(2)
    end
    it 'should render homepage layout' do
      response.should render_template('layouts/homepage')
    end
    it 'should render homepage template' do
      response.should render_template('catalog/homepage')
    end
  end

  describe '#manuscripts' do
    before do
      controller.send(:manuscripts)
    end
    it 'should have a response' do
      expect(controller.instance_variable_get('@response_m')).not_to be_nil
      expect(controller.instance_variable_get('@document_list_m')).not_to be_nil
    end
    it 'should have descriptions request handler' do
      expect(controller.instance_variable_get('@response_m')['responseHeader']['params']['qt']).to eq('descriptions')
    end
  end

  describe '#transcriptions' do
    before do
      controller.send(:transcriptions)
    end
    it 'should have a response' do
      expect(controller.instance_variable_get('@response_t')).not_to be_nil
      expect(controller.instance_variable_get('@document_list_t')).not_to be_nil
    end
    it 'should have transcriptions request handler' do
      expect(controller.instance_variable_get('@response_t')['responseHeader']['params']['qt']).to eq('transcriptions')
    end
  end

  describe '#annotations' do
    before do
      controller.send(:annotations)
    end
    it 'should have a response' do
      expect(controller.instance_variable_get('@response_a')).not_to be_nil
      expect(controller.instance_variable_get('@document_list_a')).not_to be_nil
    end
    it 'should have annotations request handler' do
      expect(controller.instance_variable_get('@response_a')['responseHeader']['params']['qt']).to eq('annotations')
    end
  end

  describe 'blacklight config' do
    let(:config) { controller.blacklight_config }
    it 'should have the correct facet order' do
      keys = config.facet_fields.keys
      expect(keys.index('format')).to be < keys.index('type_of_resource_facet')
      expect(keys.index('type_of_resource_facet')).to be < keys.index('authors_all_facet')
      expect(keys.index('authors_all_facet')).to be < keys.index('topic_facet')
      expect(keys.index('topic_facet')).to be < keys.index('geographic_facet')
      expect(keys.index('geographic_facet')).to be < keys.index('era_facet')
      expect(keys.index('era_facet')).to be < keys.index('manuscript_facet')
      expect(keys.index('manuscript_facet')).to be < keys.index('language')
      expect(keys.index('language')).to be < keys.index('place_search')
      expect(keys.index('place_search')).to be < keys.index('model')
      expect(keys.index('model')).to be < keys.index('folio')
      expect(keys.index('folio')).to be < keys.index('collection')
      expect(keys.index('collection')).to be < keys.index('date_range')
    end
    describe 'sort fields' do
      it 'should have the correct sort options' do
        expect(config.sort_fields.keys).to eq ['score desc, title_sort asc', 'authors_all_facet asc, title_sort asc',
                                               'pub_date_sort asc, title_sort asc']
      end
      it 'should have the correct sort order' do
        keys = config.sort_fields.keys
        expect(keys.index('score desc, title_sort asc')).to be < keys.index('authors_all_facet asc, title_sort asc')
        expect(keys.index('authors_all_facet asc, title_sort asc')).to be < keys.index('pub_date_sort asc, title_sort asc')
      end
    end
    describe 'search types' do
      it 'should include all fields search' do
        search_field = config.search_fields['all_fields']
        expect(search_field).to be_present
        expect(search_field.label).to eq 'All Fields'
      end
      it 'should include descriptions search' do
        search_field = config.search_fields['descriptions']
        expect(search_field).to be_present
        expect(search_field.label).to eq 'Descriptions'
      end
      it 'should include transcriptions search' do
        search_field = config.search_fields['transcriptions']
        expect(search_field).to be_present
        expect(search_field.label).to eq 'Transcriptions'
      end
      it 'should include annotations search' do
        search_field = config.search_fields['annotations']
        expect(search_field).to be_present
        expect(search_field.label).to eq 'Annotations'
      end
    end
  end
end
