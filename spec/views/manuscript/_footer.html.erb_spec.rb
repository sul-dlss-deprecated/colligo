require 'spec_helper'

describe '/manuscript/_footer.html.erb' do
  it 'should render the manuscript page footer' do
    stub_template 'shared/_previous_record.html.erb' => '<span>Previous record</span>'
    stub_template 'shared/_next_record.html.erb' => '<span>Next record</span>'
    stub_template 'shared/_top.html.erb' => '<span>Top</span>'
    render
    expect(rendered).to have_css('div.col-md-4 span', text: 'Previous record')
    expect(rendered).to have_css('div.col-md-8 span', text: 'Next record')
    expect(rendered).to have_css('div.col-md-8 div.pull-right.footer-top span', text: 'Top')
  end
end
