require 'rails_helper'

describe '/catalog/homepage.html.erb' do
  it 'should render the home partials' do
    stub_template 'catalog/_homepage/_home.html.erb' => 'Home content'
    stub_template 'shared/_sitelinks_search_box.html.erb' => 'Sitelinks search box'
    render
    expect(rendered).to match(/Home content/)
    expect(rendered).to match(/Sitelinks search box/)
  end
end
