require 'spec_helper'

describe '/catalog/_bentopage/_constraints.html.erb' do
  before(:each) do
    allow(view).to receive(:params).and_return(q: 'foobar', search_field: 'all_fields')
    allow(view).to receive(:render_simple_constraints).with(q: 'foobar', search_field: 'all_fields').and_return('render simple constraints')
    render
  end
  it 'should render the prefix' do
    expect(rendered).to have_css('span.constraints-label', text: 'You selected')
  end
  it 'should render the constraints' do
    expect(rendered).to have_content('render simple constraints')
  end
end
