require 'spec_helper'

describe '/shared/_per_page_widget.html.erb' do
  before do
    expect(view).to receive(:show_sort_and_per_page?).and_return(true)
    expect(view).to receive(:current_per_page).at_least(:once).and_return(10)
    expect(view).to receive(:params_for_search).at_least(:once).and_return('/')
    expect(view).to receive(:blacklight_config).at_least(:once).and_return(Blacklight::Configuration.new)
  end
  it 'should have a header with a search form' do
    render
    expect(rendered).to have_css('span.sr-only', count: 1, text: 'Number of results to display per page')
    expect(rendered).to have_selector('div.page-count', count: 1) do |t|
      expect t.text.should include('show')
      expect t.text.should include('per page')
    end
    expect(rendered).to have_css('div.page-count span', count: 4)
    expect(rendered).to have_css('div.page-count span a', count: 3)
    expect(rendered).to have_css('div.page-count span:nth-child(1)', text: 10)
    expect(rendered).to have_css('div.page-count span:nth-child(2) a', text: 20)
    expect(rendered).to have_css('div.page-count span:nth-child(3) a', text: 50)
    expect(rendered).to have_css('div.page-count span:nth-child(4) a', text: 100)
  end
end
