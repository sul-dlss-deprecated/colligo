require 'spec_helper'

describe SearchBuilder do
  before(:all) do
    @cc = CatalogController.new
    @cc.params = {}
  end

  describe '#add_manuscript_filter' do
    before do
      @cc.search_params_logic += [:add_manuscript_filter]
    end
    it 'should have descriptions request handler' do
      expect(@cc.solr_search_params[:qt]).to eq('descriptions')
    end
  end

  describe '#add_annotation_filter' do
    before do
      @cc.search_params_logic += [:add_annotation_filter]
    end
    it 'should have annotations request handler' do
      expect(@cc.solr_search_params[:qt]).to eq('annotations')
    end
  end

  describe '#add_transcription_filter' do
    before do
      @cc.search_params_logic += [:add_transcription_filter]
    end
    it 'should have transcriptions request handler' do
      expect(@cc.solr_search_params[:qt]).to eq('transcriptions')
    end
  end

  describe '#all_search_filter' do
    before do
      @cc.search_params_logic += [:all_search_filter]
    end
    it 'should have search request handler' do
      expect(@cc.solr_search_params[:qt]).to eq('search')
    end
  end
end