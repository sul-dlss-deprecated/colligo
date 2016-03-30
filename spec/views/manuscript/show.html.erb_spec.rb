require 'spec_helper'

describe '/manuscript/show.html.erb' do
  it 'should render the manuscript partials' do
    stub_template 'manuscript/_header.html.erb' => 'Header'
    stub_template 'manuscript/_manifest.html.erb' => 'Manifest'
    stub_template 'manuscript/_description.html.erb' => 'Description'
    stub_template 'manuscript/_folios.html.erb' => 'Folios'
    stub_template 'manuscript/_find_all.html.erb' => 'Find all'
    stub_template 'manuscript/_footer.html.erb' => 'Footer'
    render
    expect(rendered).to have_css('div div.row div.col-md-12', text: 'Header')
    expect(rendered).to have_css('div div.row div.col-md-12', text: 'Manifest')
    expect(rendered).to have_css('div div.row div.col-md-9', text: 'Description')
    expect(rendered).to have_css('div div.row div.col-md-3', text: 'Folios')
    expect(rendered).to have_css('div div.row div.col-md-3', text: 'Find all')
    expect(rendered).to have_css('div div.row', text: 'Footer')
  end
end
