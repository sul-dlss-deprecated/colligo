require 'spec_helper'

describe '/bookmarks/index.html.erb' do
  include SolrDocumentFixtures
  describe 'There is no current or guest user' do
    before(:all) do
      @response_m = manuscript_resp
      @document_list_m = manuscript_docs
    end
    before(:each) do
      allow(view).to receive(:current_or_guest_user).and_return(nil)
      render
    end
    it 'should display the heading with number of bookmarks' do
      expect(rendered).to have_css('div.col-md-12[id="content"] h2.top-content-title', count: 1, text: '62 Bookmarks')
    end
    it 'should display the appropriate message' do
      expect(rendered).to have_css('div.col-md-12[id="content"] h3.section-heading', count: 1, text: 'Please log in to manage and view your bookmarks.')
    end
  end
  describe 'There are no records bookmarked' do
    before(:all) do
      @response_m = manuscript_resp_002
      @document_list_m = manuscript_docs_002
    end
    before(:each) do
      allow(view).to receive(:current_or_guest_user).and_return(true)
      render
    end
    it 'should display the heading with number of bookmarks' do
      expect(rendered).to have_css('div.col-md-12[id="content"] h2.top-content-title', count: 1, text: '0 Bookmarks')
    end
    it 'should display the appropriate message' do
      expect(rendered).to have_css('div.col-md-12[id="content"] h3.section-heading', count: 1, text: 'You have no bookmarks')
    end
  end
  describe 'Display bookmarked records' do
    before(:all) do
      @response_m = manuscript_resp
      @document_list_m = manuscript_docs
    end
    before(:each) do
      stub_template 'bookmarks/_clear_bookmarks_widget.html.erb' => '<div>Clear widget</div>'
      stub_template 'shared/_sort_widget.html.erb' => '<div>Sort widget</div>'
      stub_template 'shared/_manuscript.html.erb' => '<div>Manuscript</div>'
      stub_template 'shared/_results_footer.html.erb' => '<div>Results footer</div>'
      allow(view).to receive(:current_or_guest_user).and_return(true)
      render
    end
    it 'should display the heading with number of bookmarks' do
      expect(rendered).to have_css('div.col-md-12[id="content"] h2.top-content-title', count: 1, text: '62 Bookmarks')
    end
    it 'should display the clear widget' do
      expect(rendered).to have_css('div.col-md-12[id="content"] div.row[id="searchinfo"] div.col-md-12 div.pull-right div:nth-child(1)', text: 'Clear widget')
    end
    it 'should display the sort widget' do
      expect(rendered).to have_css('div.col-md-12[id="content"] div.row[id="searchinfo"] div.col-md-12 div.pull-right div:nth-child(2)', text: 'Sort widget')
    end
    it 'should display the manuscript records' do
      expect(rendered).to have_css('div.col-md-12[id="content"] div.row div.col-md-12 div', text: 'Manuscript', count: 10)
    end
    it 'should display the footer' do
      expect(rendered).to have_css('div.col-md-12[id="content"] div', text: 'Results footer')
    end
  end
end
