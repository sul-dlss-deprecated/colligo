require 'spec_helper'

describe '/catalog/_homepage/_annotations_recent.html.erb' do
  before(:each) do
    render
  end
  it 'should render headings' do
    rendered.should match('<h3.*?>by most recent</h3>')
  end
  describe 'display recent annotations' do
    it 'is a pending test'
  end
end