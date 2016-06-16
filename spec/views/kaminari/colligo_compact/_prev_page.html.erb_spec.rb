require 'spec_helper'

describe '/kaminari/colligo_compact/_prev_page.html.erb' do
  describe 'display prev page' do
    before(:each) do
      allow(view).to receive(:current_page).and_return(double(first?: false))
      allow(view).to receive(:url).and_return('/prev_page')
      render
    end
    it 'should display the link to prev page' do
      expect(rendered).to have_css('a.btn.btn-lg.btn-paginate-prev[id="previouspage"][href="/prev_page"]')
    end
    it 'should display the left arrow' do
      expect(rendered).to have_css('a.btn-paginate-prev span.glyphicon.glyphicon-arrow-left')
    end
  end
  describe 'display no previous pagination for first page' do
    before(:each) do
      allow(view).to receive(:current_page).and_return(double(first?: true))
      allow(view).to receive(:url).and_return('/prev_page')
      render
    end
    it 'should render an empty string' do
      expect(rendered).to be_empty
    end
  end
end
