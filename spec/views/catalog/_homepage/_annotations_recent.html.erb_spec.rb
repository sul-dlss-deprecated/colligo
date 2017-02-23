require 'rails_helper'

describe '/catalog/_homepage/_annotations_recent.html.erb' do
  before(:each) do
    render
  end
  it 'should render headings' do
    expect(rendered).to match('<h3.*?>by most recent</h3>')
  end
  describe 'display recent annotations' do
    it 'is a pending test'
  end
end
