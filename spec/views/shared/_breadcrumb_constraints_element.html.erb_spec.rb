require 'spec_helper'

describe 'shared/_breadcrumb_constraints_element.html.erb' do
  let(:options) { { searchpath: '/?f[geographic_facet][]=Britain&search_field=descriptions', class: 'filter-geographic_facet' } }
  it 'should render the label and value' do
    allow(view).to receive(:label).and_return('Region')
    allow(view).to receive(:value).and_return('Britain')
    allow(view).to receive(:options).and_return(options)
    allow(view).to receive(:url_for).and_return('/?f[geographic_facet][]=Britain&search_field=descriptions')
    render
    expect(rendered).to have_css('a.btn-link span.breadcrumbValue', text: 'Britain')
    expect(rendered).to have_link('Britain', href: '/?f[geographic_facet][]=Britain&search_field=descriptions')
  end
end
