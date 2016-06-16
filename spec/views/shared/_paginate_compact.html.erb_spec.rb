require 'spec_helper'

describe 'shared/_paginate_compact.html.erb' do
  describe 'with a real solr response' do
    def blacklight_config
      @config ||= CatalogController.blacklight_config
    end

    def blacklight_config=(config)
      @config = config
    end

    def facet_limit_for(*_args)
      0
    end

    include Blacklight::SearchHelper

    it 'should render solr responses' do
      solr_response, _document_list = search_results({ q: '' }, CatalogController.search_params_logic)
      allow(view).to receive(:url_for).and_return('/url')
      render partial: 'shared/paginate_compact', object: solr_response
      expect(rendered).to have_selector '.page_entries'
      expect(rendered).to have_selector 'a[@rel=next]'
    end
  end

  it 'should render paginatable arrays' do
    allow(view).to receive(:url_for).and_return('/url')
    render partial: 'shared/paginate_compact', object: Kaminari.paginate_array([], total_count: 145).page(1).per(10)
    expect(rendered).to have_selector '.page_entries'
    expect(rendered).to have_selector 'a[@rel=next]'
  end

  it 'should render ActiveRecord collections' do
    allow(view).to receive(:url_for).and_return('/url')
    50.times { b = Bookmark.new; b.user_id = 1; b.save! }
    render partial: 'shared/paginate_compact', object: Bookmark.page(1).per(25)
    expect(rendered).to have_selector '.page_entries'
    expect(rendered).to have_selector 'a[@rel=next]'
  end
end
