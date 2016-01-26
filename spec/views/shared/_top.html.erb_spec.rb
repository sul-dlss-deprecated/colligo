require 'spec_helper'

describe 'shared/_top.html.erb' do
  it 'should render the top button' do
    render
    expect(rendered).to have_css('a', text: 'Top', count: 1)
    expect(rendered).to have_css('a[class="btn btn-lg btn-top"][href="#"]', text: 'Top', count: 1)
    expect(rendered).to have_css('a span', count: 1)
    expect(rendered).to have_css('a.btn-top[href="#"] span[class="glyphicon glyphicon-arrow-up"]', count: 1)
  end
end