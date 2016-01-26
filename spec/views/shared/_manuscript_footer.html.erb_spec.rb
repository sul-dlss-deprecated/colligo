require 'spec_helper'

describe 'shared/_manuscript_footer.html.erb' do
  include SolrDocumentFixtures
  before(:all) do
    @related_annotations = related_annotations
    @related_transcriptions = related_transcriptions
  end
  it 'should render the footer with annotations' do
    stub_template 'shared/_bookmark_control.html.erb' => '<span>Bookmark control</span>'
    allow(view).to receive(:document).and_return(manuscript_docs[0]) # related annotations
    allow(view).to receive(:search_action_path).with({'search_field'=>'annotations', 'f'=>{'manuscript_facet'=>['Gospel Lectionary']}}).and_return('/abcd&search_field=annotations')
    allow(view).to receive(:search_action_path).with({'search_field'=>'transcriptions', 'f'=>{'manuscript_facet'=>['Gospel Lectionary']}}).and_return('/efgh&search_field=transcriptions')
    render
    expect(rendered).to have_css('a.result[href="/abcd&search_field=annotations"]')
    expect(rendered).to have_css('a.result span.glyphicon-tag')
    expect(rendered).to have_css('a.result', text: 'Annotations', count: 1)
    expect(rendered).to have_css('a.noresult[href="/efgh&search_field=transcriptions"]')
    expect(rendered).to have_css('a.noresult span.glyphicon-pencil')
    expect(rendered).to have_css('a.noresult', text: 'Transcriptions', count: 1)
    expect(rendered).to have_css('div.pull-right span', text: 'Bookmark control', count: 1)
  end
  it 'should render the footer with transcriptions' do
    stub_template 'shared/_bookmark_control.html.erb' => '<span>Bookmark control</span>'
    allow(view).to receive(:document).and_return(manuscript_docs[2]) # related transcriptions
    allow(view).to receive(:search_action_path).with({'search_field'=>'annotations', 'f'=>{'manuscript_facet'=>['Walters Ms. W.528, Gospel Book']}}).and_return('/abcd&search_field=annotations')
    allow(view).to receive(:search_action_path).with({'search_field'=>'transcriptions', 'f'=>{'manuscript_facet'=>['Walters Ms. W.528, Gospel Book']}}).and_return('/efgh&search_field=transcriptions')
    render
    expect(rendered).to have_css('a.noresult[href="/abcd&search_field=annotations"]')
    expect(rendered).to have_css('a.noresult span.glyphicon-tag')
    expect(rendered).to have_css('a.noresult', text: 'Annotations', count: 1)
    expect(rendered).to have_css('a.result[href="/efgh&search_field=transcriptions"]')
    expect(rendered).to have_css('a.result span.glyphicon-pencil')
    expect(rendered).to have_css('a.result', text: 'Transcriptions', count: 1)
    expect(rendered).to have_css('div.pull-right span', text: 'Bookmark control', count: 1)
  end
  it 'should render the footer with transcriptions and annotations' do
    stub_template 'shared/_bookmark_control.html.erb' => '<span>Bookmark control</span>'
    allow(view).to receive(:document).and_return(manuscript_docs[3]) # related annotations and transcriptions
    allow(view).to receive(:search_action_path).with({'search_field'=>'annotations', 'f'=>{'manuscript_facet'=>['Walters Ms. W.520, Gospel Lectionary']}}).and_return('/abcd&search_field=annotations')
    allow(view).to receive(:search_action_path).with({'search_field'=>'transcriptions', 'f'=>{'manuscript_facet'=>['Walters Ms. W.520, Gospel Lectionary']}}).and_return('/efgh&search_field=transcriptions')
    render
    expect(rendered).to have_css('a.result[href="/abcd&search_field=annotations"]')
    expect(rendered).to have_css('a.result span.glyphicon-tag')
    expect(rendered).to have_css('a.result', text: 'Annotations', count: 1)
    expect(rendered).to have_css('a.result[href="/efgh&search_field=transcriptions"]')
    expect(rendered).to have_css('a.result span.glyphicon-pencil')
    expect(rendered).to have_css('a.result', text: 'Transcriptions', count: 1)
    expect(rendered).to have_css('div.pull-right span', text: 'Bookmark control', count: 1)
  end
  it 'should render the footer with no transcriptions and no annotations' do
    stub_template 'shared/_bookmark_control.html.erb' => '<span>Bookmark control</span>'
    allow(view).to receive(:document).and_return(manuscript_docs[5]) # related annotations and transcriptions
    allow(view).to receive(:search_action_path).with({'search_field'=>'annotations', 'f'=>{'manuscript_facet'=>['Walters Ms. W.527, Gospel Book']}}).and_return('/abcd&search_field=annotations')
    allow(view).to receive(:search_action_path).with({'search_field'=>'transcriptions', 'f'=>{'manuscript_facet'=>['Walters Ms. W.527, Gospel Book']}}).and_return('/efgh&search_field=transcriptions')
    render
    expect(rendered).to have_css('a.noresult[href="/abcd&search_field=annotations"]')
    expect(rendered).to have_css('a.noresult span.glyphicon-tag')
    expect(rendered).to have_css('a.noresult', text: 'Annotations', count: 1)
    expect(rendered).to have_css('a.noresult[href="/efgh&search_field=transcriptions"]')
    expect(rendered).to have_css('a.noresult span.glyphicon-pencil')
    expect(rendered).to have_css('a.noresult', text: 'Transcriptions', count: 1)
    expect(rendered).to have_css('div.pull-right span', text: 'Bookmark control', count: 1)
  end
end
