require 'rails_helper'

describe 'shared/_manuscript.html.erb' do
  before(:all) do
    @response_m = { 'response' => { 'start' => 10 } }
  end
  before(:each) do
    stub_template 'shared/_manuscript_body.html.erb' => '<div>Manuscript body</div>'
    stub_template 'shared/_manuscript_footer.html.erb' => '<div>Manuscript footer</div>'
    allow(view).to receive(:document).and_return('<p>Document</p>')
    allow(view).to receive(:document_counter).and_return(2)
    allow(view).to receive(:show_manifest).and_return(true)
  end
  it 'should render the manuscript body and footer' do
    allow(view).to receive(:show_footer).and_return(true)
    render
    expect(rendered).to have_css('div.panel div.panel-body div', text: 'Manuscript body')
    expect(rendered).to have_css('div.panel div.panel-footer div', text: 'Manuscript footer')
  end
  it 'should render the manuscript body' do
    allow(view).to receive(:show_footer).and_return(false)
    render
    expect(rendered).to have_css('div.panel div.panel-body div', text: 'Manuscript body')
    expect(rendered).not_to have_css('div.panel div.panel-footer div', text: 'Manuscript footer')
  end
end
