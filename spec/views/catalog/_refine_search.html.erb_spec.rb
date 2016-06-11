require 'spec_helper'

describe '/catalog/_refine_search.html.erb' do
  before(:each) do
    stub_template 'catalog/_refine_facets.html.erb' => '<div class="refine_facets">Refine facets</div>'
    render
  end
  it 'should include the partial' do
    expect(rendered).to have_selector 'div', count: 1
    expect(rendered).to have_selector 'div.refine_facets', count: 1
  end

end