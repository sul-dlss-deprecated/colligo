require 'spec_helper'

describe '/shared/_results_header.html.erb' do
  it 'should render the results header' do
    stub_template 'shared/_simple_constraints.html.erb' => '<span>Simple constraints</span>'
    stub_template 'shared/_sort_widget.html.erb' => '<span>Sort widget</span>'
    stub_template 'catalog/_did_you_mean.html.erb' => '<span>did_you_mean</span>'
    render
    expect(rendered).to have_css('span', text: 'did_you_mean')
    expect(rendered).to have_css('div#searchinfo')
    expect(rendered).to have_css('div#searchinfo div span', text: 'Simple constraints')
    expect(rendered).to have_css('div#searchinfo div span', text: 'Sort widget')
  end
end
