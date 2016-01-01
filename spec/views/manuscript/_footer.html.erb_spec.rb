require 'spec_helper'

describe '/manuscript/_footer.html.erb' do
  it 'should render the manuscript page footer' do
    stub_template 'shared/_top.html.erb' => '<span>Top</span>'
    render
    expect(rendered).to have_css('div.footer-prev-result')
    expect(rendered).to have_css('div.footer-top span', text: 'Top')
    expect(rendered).to have_css('div.footer-next-result')
  end
end
