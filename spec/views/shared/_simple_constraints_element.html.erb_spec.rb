require 'spec_helper'

describe 'shared/_simple_constraints_element.html.erb' do
  it 'should render the label and value' do
    allow(view).to receive(:label).and_return('Descriptions')
    allow(view).to receive(:value).and_return('gospel')
    render
    expect(rendered).to have_css('span.constraint')
    expect(rendered).to have_css('span.constraint span.filterValue', text: 'gospel')
    expect(rendered).to have_css('span.constraint span.filterName', text: 'Descriptions')
  end
  describe 'should render the optional classes' do
    it 'is a pending test'
    # it 'should render the optional classes' do
    #   allow(view).to receive(:label).and_return('Descriptions')
    #   allow(view).to receive(:value).and_return('gospel')
    #   allow(view).to receive(:options).and_return({:classes => %w(mine yours)})
    #   render
    #   expect(rendered).to have_css('span.constraint.mine.yours') # This fails
    # end
  end
end
