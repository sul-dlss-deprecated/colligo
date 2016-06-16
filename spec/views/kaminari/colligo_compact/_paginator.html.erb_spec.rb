require 'spec_helper'

describe '/kaminari/colligo_compact/_paginator.html.erb' do
  describe 'display pagination' do
    before(:each) do
      allow(view).to receive(:total_pages).and_return(5)
      allow(view).to receive(:prev_page_tag).and_return('<div id="previouspage">previous page</div>')
      allow(view).to receive(:next_page_tag).and_return('<div id="nextpage">next page</div>')
      # allow(view).to receive(:paginator).and_return(double(render: true))
      render
    end
    it 'is a pending test'
    # it 'should display the previous page' do
    #   expect(rendered).to have_css('div.pull-left.prev-page div[id="previouspage"]', text: 'previous page')
    # end
    # it 'should display the next page' do
    #   expect(rendered).to have_css('div.pull-right div[id="nextpage"]', text: 'next page')
    # end
  end
  describe 'display no pagination if only one page' do
    before(:each) do
      allow(view).to receive(:total_pages).and_return(1)
      render
    end
    it 'should render an empty string' do
      expect(rendered).to be_empty
    end
  end
end
