require 'spec_helper'

describe ManuscriptController do
  describe '#show manuscript page' do
    include IiifManifestFixtures
    before(:all) do
      @sd = SolrDocument.new
      @keys_defined = @sd.all_display_fields - @sd.single_valued_display_fields
    end
    before do
      response1 = File.open("#{::Rails.root}/spec/fixtures/iiif_manifest_records/manifest_001.json").read
      stub_request(:get, 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/manifest.json')
        .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
        .to_return(status: 200, body: response1, headers: {})
      get :show, id: 'kq131cs7229'
    end
    it 'should have manuscript with all multivalued keys not nil' do
      expect(controller.instance_variable_get('@response')).not_to be_nil
      expect(controller.instance_variable_get('@document')).not_to be_nil
      expect(controller.instance_variable_get('@document')['druid']).to eq('kq131cs7229')
      expect(@keys_defined - controller.instance_variable_get('@document').keys).to be_empty
    end
    it 'should have manifest contents' do
      expect(controller.instance_variable_get('@contents')).not_to be_nil
      expect(controller.instance_variable_get('@contents')).to be_a(Array)
      expect(controller.instance_variable_get('@contents').length).to eq(36)
    end
    it 'should render blacklight layout' do
      response.should render_template('layouts/blacklight')
    end
    it 'should render show template' do
      response.should render_template('manuscript/show')
    end
  end
end
