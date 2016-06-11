require 'spec_helper'

describe 'shared/_simple_constraints.html.erb' do
  it 'should render the query and facet constraints' do
    allow(view).to receive(:query_has_constraints?).and_return(true)
    allow(view).to receive(:query_has_search_constraints?).and_return(true)
    allow(view).to receive(:render_constraints_query).and_return(raw '<span>Search constraints</span>')
    allow(view).to receive(:query_has_facet_constraints?).and_return(true)
    allow(view).to receive(:render_constraints_filters).and_return(raw '<span>Facet constraints</span>')
    render
    expect(rendered).to have_css('div span', text: 'You searched')
    expect(rendered).to have_css('div span', text: 'Search constraints')
    expect(rendered).to have_css('div span', text: 'You selected')
    expect(rendered).to have_css('div span', text: 'Facet constraints')
  end
  it 'should render the query constraints' do
    allow(view).to receive(:query_has_constraints?).and_return(true)
    allow(view).to receive(:query_has_search_constraints?).and_return(true)
    allow(view).to receive(:render_constraints_query).and_return(raw '<span>Search constraints</span>')
    allow(view).to receive(:query_has_facet_constraints?).and_return(false)
    allow(view).to receive(:render_constraints_filters).and_return(raw '<span>Facet constraints</span>')
    render
    expect(rendered).to have_css('div span', text: 'You searched')
    expect(rendered).to have_css('div span', text: 'Search constraints')
    expect(rendered).not_to have_css('div span', text: 'You selected')
    expect(rendered).not_to have_css('div span', text: 'Facet constraints')
  end
  it 'should render the facet constraints' do
    allow(view).to receive(:query_has_constraints?).and_return(true)
    allow(view).to receive(:query_has_search_constraints?).and_return(false)
    allow(view).to receive(:render_constraints_query).and_return(raw '<span>Search constraints</span>')
    allow(view).to receive(:query_has_facet_constraints?).and_return(true)
    allow(view).to receive(:render_constraints_filters).and_return(raw '<span>Facet constraints</span>')
    render
    expect(rendered).not_to have_css('div span', text: 'You searched')
    expect(rendered).not_to have_css('div span', text: 'Search constraints')
    expect(rendered).to have_css('div span', text: 'You selected')
    expect(rendered).to have_css('div span', text: 'Facet constraints')
  end
  it 'should render nothing if no constraints' do
    allow(view).to receive(:query_has_constraints?).and_return(false)
    allow(view).to receive(:query_has_search_constraints?).and_return(false)
    allow(view).to receive(:render_constraints_query).and_return(raw '<span>Search constraints</span>')
    allow(view).to receive(:query_has_facet_constraints?).and_return(false)
    allow(view).to receive(:render_constraints_filters).and_return(raw '<span>Facet constraints</span>')
    render
    expect(rendered).not_to have_css('div span', text: 'You searched')
    expect(rendered).not_to have_css('div span', text: 'Search constraints')
    expect(rendered).not_to have_css('div span', text: 'You selected')
    expect(rendered).not_to have_css('div span', text: 'Facet constraints')
  end
end
