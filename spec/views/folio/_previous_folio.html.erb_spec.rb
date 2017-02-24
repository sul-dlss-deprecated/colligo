require 'rails_helper'

describe '/folio/_previous_folio.html.erb' do
  before(:all) do
    @previous_folio = { 'label' => 'f. 100v', 'img' => '/prev_img' }
    @url = '/manuscript/abcd/folio/f. 100v?start=0&view=efgh'
  end
  before(:each) do
    allow(view).to receive(:params).and_return(manuscript_id: 'abcd', start: 0, view: 'efgh')
    render
  end
  it 'should display the right arrow and text with link' do
    expect(rendered).to have_css('a.btn.btn-lg.btn-paginate-prev[id="previouspage"][href="' + @url + '"]')
    expect(rendered).to have_css('a[id="previouspage"] span:nth-child(1).prev_result', text: 'f. 100v')
    expect(rendered).to have_css('a[id="previouspage"] span:nth-child(2).glyphicon.glyphicon-arrow-left')
  end
  it 'should display the thumbnail with link for all form factors but extra small' do
    expect(rendered).to have_css('div.hidden-xs a[href="' + @url + '"] img.media-object.results-thumbnail[src="/prev_img"]')
  end
end
