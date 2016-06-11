require 'spec_helper'

describe '/kaminari/colligo_compact/_next_page.html.erb' do
  describe 'display next page' do
    before(:each) do
      allow(view).to receive(:current_page).and_return(double(last?: false))
      allow(view).to receive(:url).and_return('/next_page')
      allow(view).to receive(:page_entries_info).and_return('displaying page info')
      render
    end
    it 'should display the link to next page' do
      expect(rendered).to have_css('a.btn.btn-lg.btn-paginate-next[id="nextpage"][href="/next_page"]')
    end
    it 'should display the right arrow' do
      expect(rendered).to have_css('a.btn-paginate-next div.col-md-3 span.glyphicon.glyphicon-arrow-right')
    end
    it 'should display the info for next page' do
      expect(rendered).to have_css('a.btn-paginate-next div.col-md-9 span.page_entries', text: 'displaying page info ')
    end
  end
  describe 'display last page' do
    before(:each) do
      allow(view).to receive(:current_page).and_return(double(last?: true))
      allow(view).to receive(:url).and_return('/next_page')
      allow(view).to receive(:page_entries_info).and_return('displaying page info')
      render
    end
    it 'should display the link to next page' do
      expect(rendered).to have_css('a.btn.btn-lg.btn-paginate-next[id="nextpage"][href="/next_page"]')
    end
    it 'should display the info for next page' do
      expect(rendered).to have_css('a.btn-paginate-next span.page_entries', text: 'displaying page info ')
    end
  end
end

