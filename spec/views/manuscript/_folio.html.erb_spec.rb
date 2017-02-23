require 'rails_helper'

describe 'manuscript/_folio.html.erb' do
  it 'should render the panel for folio' do
    render
    expect(rendered).to have_css('div.panel-heading h3.panel-title', text: 'Current folio: ')
    expect(rendered).to have_css('div.panel-heading h3.panel-title span.foliotitle')
    expect(rendered).to have_css('div.panel-body div.media div.media-left.folio-img')
    expect(rendered).to have_css('div.panel-body div.media div.media-body div.folio-transcriptions')
    expect(rendered).to have_css('div.panel-body div.media div.media-body div.folio-annotations')
    expect(rendered).to have_css('div.panel-body div.folio-first-transcription')
  end
end
