require 'rails_helper'

describe 'shared/_clear_all_element.html.erb' do
  describe 'there are no params to clear' do
    before do
      render partial: 'shared/clear_all_element', locals: { label: 'Clear All', options: { classes: ['clear-all'], remove: {} } }
    end
    it 'should display just the outer tag' do
      expect(rendered).to have_css('span', count: 1)
      expect(rendered).to have_css('span.btn-group.appliedFilter.constraint.clear-all', count: 1)
    end
  end
  describe 'there are params to clear' do
    # it 'is a pending test'
    before do
      render partial: 'shared/clear_all_element', locals: { label: 'Clear All', options: { classes: ['clear-all'], remove: 'http://remove' } }
    end
    it 'should display the outer tag along with the delete button' do
      expect(rendered).to have_css('span', count: 3)
      expect(rendered).to have_css('span.btn-group.appliedFilter.constraint.clear-all', count: 1)
      expect(rendered).to have_css('span.clear-all a.remove.dropdown-toggle[href="http://remove"]', count: 1)
      expect(rendered).to have_css('span.clear-all a.remove span.glyphicon-remove', count: 1)
      expect(rendered).to have_css('span.clear-all a.remove span.text', count: 1, text: 'Clear All')
    end
  end
end
