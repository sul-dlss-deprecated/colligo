require 'spec_helper'

describe '/folio/_description.html.erb' do
  include SolrDocumentFixtures
  describe 'There are annotations and transcriptions with current view annotations' do
    before(:all) do
      @annotations = annotation_docs
      @transcriptions = transcription_docs
    end
    before(:each) do
      allow(view).to receive(:params).and_return(view: 'annotations', id: 'f. 8r')
      render
    end
    it 'should display the outer div' do
      expect(rendered).to have_css('div.tabbable.tabs-below', count: 1)
    end
    it 'should display the tab navigations' do
      expect(rendered).to have_css('div.tabbable.tabs-below ul.nav.nav-tabs.folio-tabs', count: 1)
      expect(rendered).to have_css('ul.nav.nav-tabs.folio-tabs li', count: 2)
      expect(rendered).to have_css('ul.nav.nav-tabs.folio-tabs li:nth-child(1).active[data-tab-id="annotations"]')
      expect(rendered).to have_css('ul.nav.nav-tabs.folio-tabs li:nth-child(2)[data-tab-id="transcriptions"]')
    end
    it 'should display the tab bodies' do
      expect(rendered).to have_css('div.tabbable.tabs-below div.tab-content[id="viewer_text"]', count: 1)
      expect(rendered).to have_css('div.tab-content[id="viewer_text"] div.tab-pane', count: 2)
      expect(rendered).to have_css('div.tab-content[id="viewer_text"] div:nth-child(1).tab-pane.active[id="annotations"]')
      expect(rendered).to have_css('div.tab-content[id="viewer_text"] div:nth-child(2).tab-pane[id="transcriptions"]')
    end
    it 'should display the annotation content' do
      expect(rendered).to have_css('div[id="annotations"] div.annotation_text', count: 10)
      @annotations.each_with_index do |annotation, i|
        a_id = 'anno_' + annotation['id']
        expect(rendered).to have_css('div[id="annotations"] div:nth-child(' + (i + 1).to_s + ').annotation_text[id="' + a_id + '"]') do |t|
          t.text.should include(annotation['body_chars_display'])
        end
      end
    end
    it 'should display the transcription content' do
      expect(rendered).to have_css('div[id="transcriptions"] div.transcription_text', count: 10)
      @transcriptions.each_with_index do |transcription, i|
        t_id = 'trans_' + transcription['id']
        expect(rendered).to have_css('div[id="transcriptions"] div:nth-child(' + (i + 1).to_s + ').transcription_text[id="' + t_id + '"]') do |t|
          t.text.should include(transcription['body_chars_display'])
        end
      end
    end
  end
  describe 'There are no annotations and transcriptions with current view transcriptions' do
    before(:all) do
      @annotations = annotation_docs_002
      @transcriptions = transcription_docs_002
    end
    before(:each) do
      allow(view).to receive(:params).and_return(view: 'transcriptions', id: 'f. 8r')
      render
    end
    it 'should display the outer div' do
      expect(rendered).to have_css('div.tabbable.tabs-below', count: 1)
    end
    it 'should display the tab navigations' do
      expect(rendered).to have_css('div.tabbable.tabs-below ul.nav.nav-tabs.folio-tabs', count: 1)
      expect(rendered).to have_css('ul.nav.nav-tabs.folio-tabs li', count: 2)
      expect(rendered).to have_css('ul.nav.nav-tabs.folio-tabs li:nth-child(1)[data-tab-id="annotations"]')
      expect(rendered).to have_css('ul.nav.nav-tabs.folio-tabs li:nth-child(2).active[data-tab-id="transcriptions"]')
    end
    it 'should display the tab bodies' do
      expect(rendered).to have_css('div.tabbable.tabs-below div.tab-content[id="viewer_text"]', count: 1)
      expect(rendered).to have_css('div.tab-content[id="viewer_text"] div.tab-pane', count: 2)
      expect(rendered).to have_css('div.tab-content[id="viewer_text"] div:nth-child(1).tab-pane[id="annotations"]')
      expect(rendered).to have_css('div.tab-content[id="viewer_text"] div:nth-child(2).tab-pane.active[id="transcriptions"]')
    end
    it 'should display the annotation content' do
      expect(rendered).to have_css('div[id="annotations"] div', count: 1, text: 'There are no annotations for folio f. 8r')
    end
    it 'should display the transcription content' do
      expect(rendered).to have_css('div[id="transcriptions"] div', count: 1, text: 'There are no transcriptions for folio f. 8r')
    end
  end
end
