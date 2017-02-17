require 'spec_helper'

describe SearchBuilder do
  subject(:search_builder) { described_class.new(double) }
  let(:solr_params) { {} }

  describe '#add_manuscript_filter' do
    it 'should have descriptions request handler' do
      subject.add_manuscript_filter(solr_params)
      expect(solr_params[:qt]).to eq 'descriptions'
    end
  end

  describe '#add_annotation_filter' do
    it 'should have annotations request handler' do
      subject.add_annotation_filter(solr_params)
      expect(solr_params[:qt]).to eq 'annotations'
    end
  end

  describe '#add_transcription_filter' do
    it 'should have transcriptions request handler' do
      subject.add_transcription_filter(solr_params)
      expect(solr_params[:qt]).to eq 'transcriptions'
    end
  end

  describe '#all_search_filter' do
    it 'should have search request handler' do
      subject.all_search_filter(solr_params)
      expect(solr_params[:qt]).to eq 'search'
    end
  end
end
