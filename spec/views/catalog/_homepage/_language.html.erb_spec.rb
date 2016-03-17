require 'spec_helper'

describe '/catalog/_homepage/_language.html.erb' do
  include SolrDocumentFixtures
  let(:blacklight_config) { Blacklight::Configuration.new }
  let :facet_field do
    Blacklight::Configuration::FacetField.new(field: 'language', label: 'Language', limit: 5).normalize!
  end
  before do
    @response = manuscript_resp_001
    @document = @response['response']['docs']
    @mock_display_facet_1 = double(:name => 'Language', sort: nil, offset: nil, prefix: nil, :items => @response['facet_counts']['facet_fields']['language'])
    blacklight_config.facet_fields['language'] = facet_field
    allow(@response).to receive(:aggregations).and_return('language' => @mock_display_facet_1)
  end
  before(:each) do
    allow(view).to receive(:facet_field_names).and_return([:language], :facet_limit_for => 5)
    allow(view).to receive(:search_action_path).and_return('/')
    allow(view).to receive(:search_facet_url).and_return('f[language][]=')
    allow(view).to receive(:blacklight_config).and_return(blacklight_config)
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
