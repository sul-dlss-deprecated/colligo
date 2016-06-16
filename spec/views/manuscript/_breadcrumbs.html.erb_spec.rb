require 'spec_helper'

describe 'manuscript/_breadcrumbs.html.erb' do
  include SolrDocumentFixtures
  it 'should render nothing if no data' do
    @document = manuscript_docs[0].except('authors_all_display', 'collection')
    @response = manuscript_resp
    render
    expect(rendered).to be_empty
  end
  it 'should render the collection and author' do
    @document = manuscript_docs[0]
    @response = manuscript_resp
    @bcparams = { 'search_field' => 'descriptions', f: { 'collection' => ['Parker Manuscripts'] } }
    allow(view).to receive(:render_breadcrumb_constraints_filters).with(@bcparams).and_return('Breadcrumb constraints')
    render
    expect(rendered).to have_content('Breadcrumb constraints')
    expect(rendered).to have_css('span', text: 'St Albans | Canterbury')
  end
  it 'should render the collection' do
    @document = manuscript_docs[0].except('authors_all_display')
    @response = manuscript_resp
    @bcparams = { 'search_field' => 'descriptions', f: { 'collection' => ['Parker Manuscripts'] } }
    allow(view).to receive(:render_breadcrumb_constraints_filters).with(@bcparams).and_return('Breadcrumb constraints')
    render
    expect(rendered).to have_content('Breadcrumb constraints')
    expect(rendered).not_to have_css('span', text: 'St Albans | Canterbury')
  end
  it 'should render the author' do
    @document = manuscript_docs[0].except('collection')
    @response = manuscript_resp
    @bcparams = { 'search_field' => 'descriptions', f: {} }
    allow(view).to receive(:render_breadcrumb_constraints_filters).with(@bcparams).and_return('Breadcrumb constraints')
    render
    expect(rendered).not_to have_content('Breadcrumb constraints')
    expect(rendered).to have_css('span', text: 'St Albans | Canterbury')
  end
end
