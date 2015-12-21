require 'spec_helper'

describe SolrDocument do
  describe 'ModsData' do
    it 'should include mods data' do
      expect(subject).to be_kind_of ModsData
    end
  end

  describe 'AnnotationData' do
    it 'should include annotation data' do
      expect(subject).to be_kind_of AnnotationData
    end
  end
end