require 'spec_helper'

describe '/shared/_results_footer.html.erb' do
  it 'should render the results footer' do
    stub_template 'shared/_paginate_compact.html.erb' => '<span>Compact pagination</span>'
    stub_template 'shared/_per_page_widget.html.erb' => '<span>Per page widget</span>'
    stub_template 'shared/_top.html.erb' => '<span>Top</span>'
    allow(view).to receive(:show_pagination?).and_return(true)
    render
    expect(rendered).to have_css('div.row div.col-md-12 span', text: 'Compact pagination')
    expect(rendered).to have_css('div.row div.col-md-12 div.footer-top span', text: 'Top')
    expect(rendered).to have_css('div.row div.col-md-12 div.footer-per-page span', text: 'Per page widget')
  end
end
