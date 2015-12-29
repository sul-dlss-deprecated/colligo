require 'spec_helper'

describe ManuscriptController do
  describe '#show manuscript page' do
    before do
      get :show, id: 'kq131cs7229'
      @sd = SolrDocument.new
      @keys_defined = @sd.all_display_fields - @sd.single_valued_display_fields
    end
    it 'should have manuscript with all multivalued keys not nil' do
      expect(controller.instance_variable_get('@response')).not_to be_nil
      expect(controller.instance_variable_get('@document')).not_to be_nil
      expect(controller.instance_variable_get('@document')['druid']).to eq('kq131cs7229')
      expect(@keys_defined - controller.instance_variable_get('@document').keys).to be_empty
    end
    it 'should render blacklight layout' do
      response.should render_template('layouts/blacklight')
    end
    it 'should render show template' do
      response.should render_template('manuscript/show')
    end
  end
end
