require 'spec_helper'

describe '/folio/_manifest.html.erb' do
  include SolrDocumentFixtures
  describe 'Manifest URL and canvas id are available' do
    before(:all) do
      @manuscript = manuscript_docs[0]
      @canvas_id = 'canvas-3'
    end
    it 'should display the folio viewer' do
      render
      url = @manuscript['manifest_urls'].first
      expect(rendered).to have_css('div[id="folio_viewer"][data-manifest-uri="'+url+'"][data-canvas-id="'+@canvas_id+'"]')
    end
  end
  describe 'Canvas id is not available' do
    before(:all) do
      @manuscript = manuscript_docs[0]
      @canvas_id = nil
    end
    it 'should not display the folio viewer' do
      render
      expect(rendered).to be_empty
    end
  end
  describe 'Manifest URL and canvas id are not available' do
    before(:all) do
      @manuscript = manuscript_docs[0].except('manifest_urls')
      @canvas_id = nil
    end
    it 'should not display the folio viewer' do
      render
      expect(rendered).to be_empty
    end
  end
end
