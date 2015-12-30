require 'spec_helper'

describe 'manuscript/_description/_contents.html.erb' do
  include IiifManifestFixtures
  it 'should render all the manifest contents' do
    @contents = manifest_contents
    render
    expect(rendered).to have_css('dl.dl-horizontal dt', count: 5)
    expect(rendered).to have_css('dl.dl-horizontal dt[title="1"]', text: '1')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="2"]', text: '2')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="3"]', text: '3')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="4"]', text: '4')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="5"]', text: '5')
    expect(rendered).to have_css('dl.dl-horizontal dd', count: 5)
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'oa:Annotation, sc:painting', count: 2)
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'sc:painting', count: 3)
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'oa:Annotation', count: 3)
  end
end
