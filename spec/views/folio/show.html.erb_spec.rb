require 'rails_helper'

describe '/folio/show.html.erb' do
  before(:each) do
    stub_template 'folio/_header.html.erb' => '<div>header</div>'
    stub_template 'folio/_manifest.html.erb' => '<div>manifest</div>'
    stub_template 'folio/_description.html.erb' => '<div>description</div>'
    stub_template 'folio/_footer.html.erb' => '<div>footer</div>'
    render
  end
  it 'should display the header' do
    expect(rendered).to have_css('div[id="content"] div.row:nth-child(1) div.col-md-12 div', text: 'header')
  end
  it 'should display the manifest' do
    expect(rendered).to have_css('div[id="content"] div.row:nth-child(2) div.col-md-6:nth-child(1)[id="viewer_container"] div', text: 'manifest')
  end
  it 'should display the description' do
    expect(rendered).to have_css('div[id="content"] div.row:nth-child(2) div.col-md-6:nth-child(2) div', text: 'description')
  end
  it 'should display the footer' do
    expect(rendered).to have_css('div[id="content"] div.row:nth-child(3) div.col-md-12 div', text: 'footer')
  end
end
