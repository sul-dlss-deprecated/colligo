require 'spec_helper'

describe '/shared/_annotation.html.erb' do
  include SolrDocumentFixtures
  describe 'it should render all the annotation data' do
    before(:each) do
      allow(view).to receive(:document).and_return(annotation_docs[0])
      render
    end
    it 'should have an image' do
      expect(rendered).to have_css('div.media div.media-left img.results-thumbnail[src="https://stacks.stanford.edu/image/iiif/xs067jx3704%2FW528_000001_300/full/!400,400/0/default.jpg"]', count: 1)
    end
    it 'should have a title truncated to 150 characters' do
      expect(rendered).to have_css('div.media div.media-body h4.media-heading', text: 'Erant aut[em] qui manducaverant Erant aut[em] qui manducaverant Erant aut[em] qui manducaverant Erant aut[em] qui manducaverant Erant aut[em] qui m...')
    end
    it 'should be linked to the id' do
      expect(rendered).to have_css('div.media div.media-body h4.media-heading a[href="/annotations/_:N43deaea09a5345379218db8cb72600c3"]')
    end
    it 'should display authors' do
      expect(rendered).to have_css('p', text: 'Joe BloggJohn Smith')
    end
    it 'should display the body type' do
      expect(rendered).to have_css('p', text: 'cnt:ContentAsText')
    end
    it 'should display the folio' do
      expect(rendered).to have_css('p', text: 'f. 8r')
    end
    it 'should display the manuscript' do
      expect(rendered).to have_css('p', text: 'Manuscript fragment of the Gospels and Canonical Epistles, glossed')
    end
  end
  describe 'it should render all available annotation data' do
    before(:each) do
      allow(view).to receive(:document).and_return(annotation_docs[1])
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
      expect(rendered).to have_css('div.media div.media-body h4.media-heading a[href="/annotations/_:N14eeb4370547431db7bb7fc075e43210"]')
    end
    it 'should display available data' do
      expect(rendered).to have_css('p', count: 3)
    end
  end
  describe 'it should display id as title if none' do
    before(:each) do
      @ans = annotation_docs[1]
      @ans['body_chars_display'] = ''
      @ans['body_type'] = ''
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
      expect(rendered).to have_css('div.media div.media-body h4.media-heading a[href="/annotations/_:N14eeb4370547431db7bb7fc075e43210"]')
    end
    it 'should display available data' do
      expect(rendered).to have_css('p', count: 2)
    end
  end
end

