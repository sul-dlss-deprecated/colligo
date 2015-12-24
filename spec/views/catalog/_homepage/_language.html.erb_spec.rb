require 'spec_helper'

describe '/catalog/_homepage/_language.html.erb' do
  before(:all) do
    cc = CatalogController.new
    cc.params = {}
    cc.send(:manuscripts)
    @response = cc.instance_variable_get('@response_m')
  end
  before(:each) do
    allow(view).to receive(:search_action_path).and_return('/')
    allow(view).to receive(:search_facet_url).and_return('f[language][]=')
    allow(view).to receive(:blacklight_config).and_return(CatalogController.new.blacklight_config)
    allow(view).to receive(:facet_limit_for).and_return(5)
    render
  end
  it 'should render headings' do
    rendered.should match('<h3.*?>by language</h3>')
  end
  it 'should render 5 facets' do
    expect(rendered).to have_css('a.btn-primary', count: 5)
  end
  it 'should render more button' do
    expect(rendered).to have_css('a.btn-primary-outline', count: 1, text: 'more Language »')
  end
end