require 'spec_helper'

describe 'folio/_breadcrumbs.html.erb' do
  include SolrDocumentFixtures
  it 'should render the collection and title' do
    @manuscript = manuscript_docs[0]
    @bcparams = { 'search_field' => 'transcriptions', f: { 'collection' => ['Parker Manuscripts'], 'manuscript_facet' => ['Gospel Lectionary'] } }
    allow(view).to receive(:render_breadcrumb_constraints_filters).with(@bcparams).and_return('Breadcrumb constraints')
    allow(view).to receive(:params).and_return(id: '12345g')
    render
    expect(rendered).to have_content('Breadcrumb constraints')
    expect(rendered).to have_css('span:nth-child(1)', text: ' > ')
    expect(rendered).to have_css('span:nth-child(2)', text: '12345g')
  end
  it 'should render the collection' do
    @manuscript = manuscript_docs[0].except('title_display')
    @bcparams = { 'search_field' => 'transcriptions', f: { 'collection' => ['Parker Manuscripts'] } }
    allow(view).to receive(:render_breadcrumb_constraints_filters).with(@bcparams).and_return('Breadcrumb constraints')
    allow(view).to receive(:params).and_return(id: '12345g')
    render
    expect(rendered).to have_content('Breadcrumb constraints')
    expect(rendered).to have_css('span:nth-child(1)', text: ' > ')
    expect(rendered).to have_css('span:nth-child(2)', text: '12345g')
  end
  it 'should render the title' do
    @manuscript = manuscript_docs[0].except('collection')
    @bcparams = { 'search_field' => 'transcriptions', f: { 'manuscript_facet' => ['Gospel Lectionary'] } }
    allow(view).to receive(:render_breadcrumb_constraints_filters).with(@bcparams).and_return('Breadcrumb constraints')
    allow(view).to receive(:params).and_return(id: '12345g')
    render
    expect(rendered).to have_content('Breadcrumb constraints')
    expect(rendered).to have_css('span:nth-child(1)', text: ' > ')
    expect(rendered).to have_css('span:nth-child(2)', text: '12345g')
  end
  it 'should render just folio if no collection and title' do
    @manuscript = manuscript_docs[0].except('collection', 'title_display')
    @bcparams = { 'search_field' => 'transcriptions', f: {} }
    allow(view).to receive(:params).and_return(id: '12345g')
    render
    expect(rendered).not_to have_content('Breadcrumb constraints')
    expect(rendered).to have_css('span:nth-child(1)', text: '12345g')
  end
end
