require 'rails_helper'

describe '/catalog/_homepage/_annotations_author.html.erb' do
  before(:each) do
    render
  end
  it 'should render headings' do
    expect(rendered).to match('<h3.*?>by author</h3>')
  end
  describe 'display author facet' do
    it 'is a pending test'
  end
end
