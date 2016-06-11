require 'spec_helper'

describe '/folio/_header.html.erb' do
  include SolrDocumentFixtures
  describe 'Display the iiif logo linked to the manifest for transcriptions' do
    before(:all) do
      @manuscript = manuscript_docs[0]
    end
    before(:each) do
      allow(view).to receive(:params).and_return(view: 'transcriptions')
      stub_template 'folio/_breadcrumbs.html.erb' => '<div>Breadcrumbs</div>'
      render
    end
    it 'should display the media tag' do
      expect(rendered).to have_css('div.media', count:1)
      expect(rendered).to have_css('div.media div:nth-child(1).media-body')
      expect(rendered).to have_css('div.media div:nth-child(2).media-right')
    end
    it 'should display the title for the folio view' do
      expect(rendered).to have_css('div.media div:nth-child(1).media-body h1[id="folio-title"]', text: 'Transcriptions')
    end
    it 'should display the IIIF logo with manifest url' do
      href = @manuscript['manifest_urls'].first
      expect(rendered).to have_css('div.media div:nth-child(2).media-right div.iiif-logo a[href="'+href+'"]')
      expect(rendered).to have_css('div.media div:nth-child(2).media-right div.iiif-logo a img[src="/assets/iiif-logo.png"]')
    end
    it 'should display the breadcrumbs' do
      expect(rendered).to have_css('div:nth-child(2) div', text: 'Breadcrumbs')
    end
  end
  describe 'Display the header without the iiif logo for annotations' do
    before(:all) do
      @manuscript = manuscript_docs[0].except('manifest_urls')
    end
    before(:each) do
      allow(view).to receive(:params).and_return(view: 'annotations')
      stub_template 'folio/_breadcrumbs.html.erb' => '<div>Breadcrumbs</div>'
      render
    end
    it 'should display the media tag' do
      expect(rendered).to have_css('div.media', count:1)
      expect(rendered).to have_css('div.media div:nth-child(1).media-body')
      expect(rendered).to have_css('div.media div:nth-child(2).media-right')
    end
    it 'should display the title for the folio view' do
      expect(rendered).to have_css('div.media div:nth-child(1).media-body h1[id="folio-title"]', text: 'Annotations')
    end
    it 'should not display the IIIF logo' do
      expect(rendered).to have_css('div.media div:nth-child(2).media-right', text: '')
    end
    it 'should display the breadcrumbs' do
      expect(rendered).to have_css('div:nth-child(2) div', text: 'Breadcrumbs')
    end
  end
end

