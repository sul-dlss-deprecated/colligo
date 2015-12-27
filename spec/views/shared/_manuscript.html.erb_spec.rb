require 'spec_helper'

describe 'shared/_manuscript.html.erb' do
  it 'should render the manuscript body and footer' do
    stub_template 'shared/_manuscript_body.html.erb' => '<div>Manuscript body</div>'
    stub_template 'shared/_manuscript_footer.html.erb' => '<div>Manuscript footer</div>'
    allow(view).to receive(:show_footer).and_return(true)
    allow(view).to receive(:show_manifest).and_return(true)
    allow(view).to receive(:document).and_return('<p>Document</p>')
    render
    expect(rendered).to have_css('div.panel div.panel-body div', text: 'Manuscript body')
    expect(rendered).to have_css('div.panel div.panel-footer div', text: 'Manuscript footer')
  end
  it 'should render the manuscript body' do
    stub_template 'shared/_manuscript_body.html.erb' => '<div>Manuscript body</div>'
    stub_template 'shared/_manuscript_footer.html.erb' => '<div>Manuscript footer</div>'
    allow(view).to receive(:show_footer).and_return(false)
    allow(view).to receive(:show_manifest).and_return(true)
    allow(view).to receive(:document).and_return('<p>Document</p>')
    render
    expect(rendered).to have_css('div.panel div.panel-body div', text: 'Manuscript body')
    expect(rendered).not_to have_css('div.panel div.panel-footer div', text: 'Manuscript footer')
  end
end