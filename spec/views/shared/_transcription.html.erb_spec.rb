require 'rails_helper'

describe '/shared/_transcription.html.erb' do
  include SolrDocumentFixtures
  describe 'it should render all the transcription data' do
    before(:each) do
      allow(view).to receive(:document).and_return(transcription_docs[0])
      render
    end
    it 'should display the media tags within a panel' do
      expect(rendered).to have_css('div.panel.panel-content.search-panel.search-panel-auto', count: 1)
      expect(rendered).to have_css('div.panel div.panel-body.transcription-result', count: 1)
      expect(rendered).to have_css('div.panel div.panel-body.transcription-result div.media', count: 1)
    end
    it 'should have an image' do
      img_src = 'https://stacks.stanford.edu/image/iiif/kq131cs7229%252Fsulmss_misc305_008r_SM'
      expect(rendered).to have_css('div.media div.media-left img.media-object.results-thumbnail[src="' + img_src + '"]', count: 1)
    end
    it 'should have a title truncated to 150 characters' do
      txt = 'Erant aut[em] qui manducaverant Erant aut[em] qui manducaverant Erant aut[em] qui manducaverant Erant aut[em] qui manducaverant Erant aut[em] qui m...'
      expect(rendered).to have_css('div.media div.media-body h4.media-heading', text: txt)
    end
    it 'should be linked to the folio for the manuscript' do
      expect(rendered).to have_css('div.media div.media-body h4.media-heading a[href="/manuscript/kq131cs7229/folio/f. 8r?view=transcriptions"]')
    end
    it 'should display all data' do
      expect(rendered).to have_css('p', count: 4)
    end
    it 'should display authors' do
      expect(rendered).to have_selector('div.media div.media-body p strong') do |t|
        expect(t.text).to include('Joe Blogg<br/>John Smith')
      end
    end
    it 'should display the language' do
      expect(rendered).to have_css('div.media div.media-body p', text: 'Latin')
    end
    it 'should display the folio' do
      expect(rendered).to have_css('div.media div.media-body p', text: 'f. 8r')
    end
    it 'should display the manuscript' do
      expect(rendered).to have_css('div.media div.media-body p', text: 'Manuscript fragment of the Gospels and Canonical Epistles, glossed')
    end
  end
  describe 'it should render all available transcription data' do
    before(:each) do
      allow(view).to receive(:document).and_return(transcription_docs[1].except('img_info'))
      render
    end
    it 'should have an image' do
      expect(rendered).to have_css('div.media div.media-left', count: 1)
      expect(rendered).not_to have_css('div.media div.media-left img')
    end
    it 'should have a title' do
      expect(rendered).to have_css('div.media div.media-body h4.media-heading', text: 'quasi quatuor milia hominu[m] et')
    end
    it 'should be linked to the id' do
      expect(rendered).to have_css('div.media div.media-body h4.media-heading a[href="/manuscript/kq131cs7229/folio/f. 8r?view=transcriptions"]')
    end
    it 'should display available data' do
      expect(rendered).to have_css('p', count: 3)
    end
  end
  describe 'it should display id as title if none' do
    before(:each) do
      @ans = transcription_docs[1]
      @ans['body_chars_display'] = ''
      @ans['body_type'] = ''
      @ans['img_info'] = []
      @ans['language'] = []
      allow(view).to receive(:document).and_return(@ans)
      render
    end
    it 'should have an image' do
      expect(rendered).to have_css('div.media div.media-left', count: 1)
      expect(rendered).not_to have_css('div.media div.media-left img')
    end
    it 'should have a title' do
      expect(rendered).to have_css('div.media div.media-body h4.media-heading', text: '_:N14eeb4370547431db7bb7fc075e43210')
    end
    it 'should be linked to the id' do
      expect(rendered).to have_css('div.media div.media-body h4.media-heading a[href="/manuscript/kq131cs7229/folio/f. 8r?view=transcriptions"]')
    end
    it 'should display available data' do
      expect(rendered).to have_css('p', count: 2)
    end
  end
end
