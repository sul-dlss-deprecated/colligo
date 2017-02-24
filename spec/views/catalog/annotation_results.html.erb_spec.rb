require 'rails_helper'

describe '/catalog/annotation_results.html.erb' do
  include SolrDocumentFixtures
  describe 'it should render annotation search results' do
    before(:all) do
      @response_a = annotation_resp
      @document_list_a = annotation_docs
    end
    before(:each) do
      allow(view).to receive(:render_search_to_page_title).and_return('Language: latin')
      allow(view).to receive(:render_opensearch_response_metadata).and_return('')
      allow(view).to receive(:rss_feed_link_tag).and_return('')
      allow(view).to receive(:atom_feed_link_tag).and_return('')
      stub_template 'catalog/_refine_search.html.erb' => '<div>Refine search</div>'
      stub_template 'shared/_results_header.html.erb' => '<div>Results header</div>'
      stub_template 'catalog/_annotation_search_results.html.erb' => '<div>Annotation search results</div>'
      render
    end
    it 'should have a row for refine search' do
      expect(rendered).to have_selector 'div.row div.col-md-12 div.refine', count: 1
    end
    it 'should include the refine search partial' do
      expect(rendered).to have_selector 'div.refine div', count: 1, text: 'Refine search'
    end
    it 'should have results summary' do
      expect(rendered).to have_selector 'div.row div.col-md-12 div.summary', count: 1
    end
    it 'should have title with number of results' do
      expect(rendered).to have_selector 'div.summary h2.top-content-title', count: 1, text: '662 Annotations'
    end
    it 'should include the results header partial' do
      expect(rendered).to have_selector 'div.summary div', count: 1, text: 'Results header'
    end
    it 'should have content' do
      expect(rendered).to have_selector 'div#content', count: 1
    end
    it 'should include the annotation search results partial' do
      expect(rendered).to have_selector 'div#content div', count: 1, text: 'Annotation search results'
    end
  end
end
