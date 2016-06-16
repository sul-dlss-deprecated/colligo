require 'spec_helper'

describe '/manuscript/show.html.erb' do
  before(:each) do
    stub_template 'manuscript/_header.html.erb' => '<span>Header</span>'
    stub_template 'manuscript/_manifest.html.erb' => '<span>Manifest</span>'
    stub_template 'manuscript/_description.html.erb' => '<span>Description</span>'
    stub_template 'manuscript/_folios.html.erb' => '<span>Folios</span>'
    stub_template 'manuscript/_find_all.html.erb' => '<span>Find all</span>'
    stub_template 'manuscript/_footer.html.erb' => '<span>Footer</span>'
    render
  end
  it 'should render the manuscript header partial' do
    expect(rendered).to have_css('div div.row div.col-md-12 span', text: 'Header')
  end
  it 'should render the manifest partial' do
    expect(rendered).to have_css('div div.row div.col-md-12[id="viewer_container"] span', text: 'Manifest')
  end
  it 'should display the folios and description supporting different form factors' do
    # on form factors other than large display folios and find all between manifest and description
    expect(rendered).to have_css('div div.row div.hidden-lg.col-md-12 div.row span', text: 'Folios')
    expect(rendered).to have_css('div div.row div.hidden-lg.col-md-12 div.row span', text: 'Find all')
    expect(rendered).to have_css('div div.row div.col-lg-9.col-md-12[id="manuscript-description"] span', text: 'Description')
    # on large form factors display folios and find all to the right of the description
    expect(rendered).to have_css('div div.row div.col-lg-3.visible-lg div.row span', text: 'Folios')
    expect(rendered).to have_css('div div.row div.col-lg-3.visible-lg div.row span', text: 'Find all')
  end
  it 'should render the manuscript footer partial' do
    expect(rendered).to have_css('div div.row span', text: 'Footer')
  end
end
