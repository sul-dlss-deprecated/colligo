require 'spec_helper'

describe '/shared/_sort_widget.html.erb' do
  before do
    config = CatalogController.new.blacklight_config
    config.add_sort_field 'title_sort asc, pub_date_sort asc', label: 'title'
    config.add_sort_field 'pub_date_sort asc, title_sort asc', label: 'century'
    config.add_sort_field 'collection asc, title_sort asc', label: 'repository'

    expect(view).to receive(:show_sort_and_per_page?).and_return(true)
    expect(view).to receive(:active_sort_fields).at_least(:once).and_return(config.sort_fields)
    expect(view).to receive(:current_sort_field).and_return(double(label: 'title'))
    expect(view).to receive(:params_for_search).at_least(:once).and_return('/')
  end
  it 'should have a header with a search form' do
    render
    expect(rendered).to have_css('div.btn-group.pull-right[id="sort-dropdown"]', count: 1)
    expect(rendered).to have_selector('div[id="sort-dropdown"] button.btn.btn-default.dropdown-toggle[type="button"]', count: 1) do |t|
      expect t.text.should include('Sorted by')
    end
    expect(rendered).to have_css('div[id="sort-dropdown"] button.btn.btn-default.dropdown-toggle[type="button"] span', count: 2)
    expect(rendered).to have_css('div[id="sort-dropdown"] button.btn.btn-default.dropdown-toggle[type="button"] span:nth-child(1).btn-value', text: 'title')
    expect(rendered).to have_css('div[id="sort-dropdown"] button.btn.btn-default.dropdown-toggle[type="button"] span:nth-child(2).caret')
    expect(rendered).to have_css('div[id="sort-dropdown"] ul.dropdown-menu', count: 1)
    expect(rendered).to have_css('div[id="sort-dropdown"] ul.dropdown-menu li', count: 4)
    expect(rendered).to have_css('div[id="sort-dropdown"] ul.dropdown-menu li:nth-child(1) a', text: 'relevance')
    expect(rendered).to have_css('div[id="sort-dropdown"] ul.dropdown-menu li:nth-child(2) a', text: 'title')
    expect(rendered).to have_css('div[id="sort-dropdown"] ul.dropdown-menu li:nth-child(3) a', text: 'century')
    expect(rendered).to have_css('div[id="sort-dropdown"] ul.dropdown-menu li:nth-child(4) a', text: 'repository')
  end
end
