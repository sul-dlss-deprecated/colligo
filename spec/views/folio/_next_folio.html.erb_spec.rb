require 'spec_helper'

describe '/folio/_next_folio.html.erb' do
  before(:all) do
    @next_folio = {'label' => 'f. 101r', 'img' => '/next_img'}
    @url = '/manuscript/abcd/folio/f. 101r?start=0&view=efgh'
  end
  before(:each) do
    allow(view).to receive(:params).and_return(manuscript_id: 'abcd', start: 0, view: 'efgh')
    render
  end
  it 'should display the right arrow and text with link' do
    expect(rendered).to have_css('a.btn.btn-lg.btn-paginate-next[id="nextpage"][href="'+@url+'"]')
    expect(rendered).to have_css('a[id="nextpage"] span:nth-child(1).glyphicon.glyphicon-arrow-right')
    expect(rendered).to have_css('a[id="nextpage"] span:nth-child(2).next_result', text: 'f. 101r')
  end
  it 'should display the thumbnail with link for all form factors but extra small' do
    expect(rendered).to have_css('div.hidden-xs a[href="'+@url+'"] img.media-object.results-thumbnail[src="/next_img"]')
  end
end
