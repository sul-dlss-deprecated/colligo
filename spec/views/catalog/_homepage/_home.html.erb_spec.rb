require 'spec_helper'

describe '/catalog/_homepage/_home.html.erb' do
  before(:each) do
    stub_template 'catalog/_homepage/_home_text.html.erb' => 'Home text'
    stub_template 'catalog/_homepage/_home_search_form.html.erb' => 'Search box'
    stub_template 'catalog/_homepage/_repository.html.erb' => 'Repository'
    stub_template 'catalog/_homepage/_language.html.erb' => 'Language'
    stub_template 'catalog/_homepage/_century.html.erb' => 'Century'
    stub_template 'catalog/_homepage/_annotations_recent.html.erb' => 'Recent annotations'
    stub_template 'catalog/_homepage/_annotations_author.html.erb' => 'Annotations by author'
  end
  describe 'it should render a basic page when no data' do
    before(:all) do
      @data_array = []
      @response_m = {'facet_counts' => {'facet_fields' => {'collection' => [], 'language' => []}}}
      @document_list_a = []
    end
    it 'should render the home text' do
      render
      expect(rendered).to match(/Home text/)
    end
    it 'should render search heading' do
      render
      rendered.should match('<h2.*?>Search</h2>')
    end
    it 'should render the search box' do
      render
      expect(rendered).to match(/Search box/)
    end
    it 'should not render the browse manuscript heading' do
      render
      rendered.should_not match('<h2.*?>Browse manuscripts</h2>')
    end
    it 'should not render the repository facet' do
      render
      expect(rendered).not_to match(/Repository/)
    end
    it 'should not render the language facet' do
      render
      expect(rendered).not_to match(/Language/)
    end
    it 'should not render the century graph' do
      render
      expect(rendered).not_to match(/Century/)
    end
    it 'should not render the annotations heading' do
      render
      rendered.should_not match('<h2.*?>& annotations</h2>')
    end
    it 'should not render the recent annotations and facets for annotations' do
      render
      expect(rendered).not_to match(/Recent annotations/)
      expect(rendered).not_to match(/Annotations by author/)
    end
  end
  describe 'it should render heading and partials if data available' do
    before(:all) do
      @data_array = [1, 2, 3]
      @response_m = {'facet_counts' => {'facet_fields' => {'collection' => %w(a b c), 'language' => %w(English Latin)}}}
      @document_list_a = [1, 2, 3]
    end
    it 'should render the home text' do
      render
      expect(rendered).to match(/Home text/)
    end
    it 'should render search heading' do
      render
      rendered.should match('<h2.*?>Search</h2>')
    end
    it 'should render the search box' do
      render
      expect(rendered).to match(/Search box/)
    end
    it 'should render the browse manuscript heading' do
      render
      rendered.should match('<h2.*?>Browse manuscripts</h2>')
    end
    it 'should render the repository facet' do
      render
      expect(rendered).to match(/Repository/)
    end
    it 'should render the language facet' do
      render
      expect(rendered).to match(/Language/)
    end
    it 'should render the century graph' do
      render
      expect(rendered).to match(/Century/)
    end
    it 'should render the annotations heading' do
      render
      rendered.should match('<h2.*?>& annotations</h2>')
    end
    it 'should render the recent annotations and facets for annotations' do
      render
      expect(rendered).to match(/Recent annotations/)
      expect(rendered).to match(/Annotations by author/)
    end
  end
end
