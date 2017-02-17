require 'spec_helper'

describe 'manuscript/_find_all.html.erb' do
  before do
    allow(view).to receive(:search_action_path).and_return('/')
    expect(view).to receive(:path_for_facet).at_least(:once).and_return('/')
  end
  it 'should render the panel for find all with results for annotations and transcriptions' do
    @document = { 'title_display' => 'Title' }
    @related_annotations = 4
    @related_transcriptions = 34
    render
    expect(rendered).to have_css('div.panel div.panel-heading h3.panel-title', text: 'Manuscript')
    expect(rendered).to have_css('div.panel div.panel-body dl dt', text: 'Find all...')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.result-inverse', text: ' Annotations')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.result-inverse span.glyphicon-tag')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.result-inverse', text: ' Transcriptions')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.result-inverse span.glyphicon-pencil')
    expect(rendered).to have_css('div.panel div.panel-body dl dt', text: '...for this manuscript')
  end
  it 'should render the panel for find all with results for annotations' do
    @document = { 'title_display' => 'Title' }
    @related_annotations = 4
    @related_transcriptions = 0
    render
    expect(rendered).to have_css('div.panel div.panel-heading h3.panel-title', text: 'Manuscript')
    expect(rendered).to have_css('div.panel div.panel-body dl dt', text: 'Find all...')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.result-inverse', text: ' Annotations')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.result-inverse span.glyphicon-tag')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.noresult-inverse', text: ' Transcriptions')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.noresult-inverse span.glyphicon-pencil')
    expect(rendered).to have_css('div.panel div.panel-body dl dt', text: '...for this manuscript')
  end
  it 'should render the panel for find all with results for transcriptions' do
    @document = { 'title_display' => 'Title' }
    @related_annotations = 0
    @related_transcriptions = 34
    render
    expect(rendered).to have_css('div.panel div.panel-heading h3.panel-title', text: 'Manuscript')
    expect(rendered).to have_css('div.panel div.panel-body dl dt', text: 'Find all...')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.btn-sm.noresult-inverse', text: 'Annotations')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.btn-sm.noresult-inverse span.glyphicon-tag')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.btn-sm.result-inverse', text: 'Transcriptions')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.btn-sm.result-inverse span.glyphicon-pencil')
    expect(rendered).to have_css('div.panel div.panel-body dl dt', text: '...for this manuscript')
  end
  it 'should render the panel for find all with no results' do
    @document = { 'title_display' => 'Title' }
    @related_annotations = 0
    @related_transcriptions = 0
    render
    expect(rendered).to have_css('div.panel div.panel-heading h3.panel-title', text: 'Manuscript')
    expect(rendered).to have_css('div.panel div.panel-body dl dt', text: 'Find all...')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.btn-sm.noresult-inverse', text: 'Annotations')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.btn-sm.noresult-inverse span.glyphicon-tag')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.btn-sm.noresult-inverse', text: 'Transcriptions')
    expect(rendered).to have_css('div.panel div.panel-body dl dd a.btn-sm.noresult-inverse span.glyphicon-pencil')
    expect(rendered).to have_css('div.panel div.panel-body dl dt', text: '...for this manuscript')
  end
end
