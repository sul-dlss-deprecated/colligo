require 'spec_helper'

describe '/shared/_sort_widget.html.erb' do
  it 'should have a header with a search form' do
    @config = CatalogController.new.blacklight_config
    @config.add_sort_field 'title_sort asc, pub_date_sort asc', label: 'title'
    @config.add_sort_field 'pub_date_sort asc, title_sort asc', label: 'century'
    @config.add_sort_field 'collection asc, title_sort asc', label: 'repository'
    allow(view).to receive(:blacklight_config).and_return(@config)
    allow(view).to receive(:show_sort_and_per_page?).and_return(true)
    allow(view).to receive(:active_sort_fields).and_return(@config.sort_fields)
    current_sort_field = double(label: 'title')
    allow(view).to receive(:current_sort_field).and_return(current_sort_field)
    allow(view).to receive(:url_for).and_return('/url')
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

