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
    render
  end
  it 'should render the home text' do
    expect(rendered).to match(/Home text/)
  end
  it 'should render the search box' do
    expect(rendered).to match(/Search box/)
  end
  it 'should render the repository facet' do
    expect(rendered).to match(/Repository/)
  end
  it 'should render the language facet' do
    expect(rendered).to match(/Language/)
  end
  it 'should render the century graph' do
    expect(rendered).to match(/Century/)
  end
  it 'should render the recent annotations' do
    expect(rendered).to match(/Recent annotations/)
  end
  it 'should render author facets for annotations' do
    expect(rendered).to match(/Annotations by author/)
  end
  it 'should render headings' do
    rendered.should match('<h2.*?>Search</h2>')
    rendered.should match('<h2.*?>Browse manuscripts</h2>')
    rendered.should match('<h2.*?>& annotations</h2>')
  end
end
