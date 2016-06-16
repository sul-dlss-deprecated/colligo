require 'spec_helper'

describe 'manuscript/_description/_summary.html.erb' do
  include SolrDocumentFixtures
  it 'should render the abstract if available' do
    @document = manuscript_docs[9]
    render
    expect(rendered).to have_css('p', text: @document['abstract_display'])
  end
  it 'should render nil if abstract not available' do
    @document = manuscript_docs[0]
    render
    expect(rendered).to be_empty
  end
end
