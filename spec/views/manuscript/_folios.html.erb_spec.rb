require 'spec_helper'

describe '/manuscript/_folios.html.erb' do
  it 'should render the folio partials' do
    stub_template 'manuscript/_folio.html.erb' => 'Folio'
    render
    expect(rendered).to have_css('div.folio-panel.folio-recto', text: 'Folio')
    expect(rendered).to have_css('div.folio-panel.folio-verso', text: 'Folio')
  end
end
