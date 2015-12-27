require 'spec_helper'

describe 'catalog/_bentopage/_results_summary.html.erb' do
  describe 'it should render form for results' do
    before(:all) do
      @response_m = {'response' => {'numFound' => 44}}
      @response_t = {'response' => {'numFound' => 234}}
      @response_a = {'response' => {'numFound' => 4}}
    end
    before(:each) do
      stub_template 'catalog/_bentopage/_constraints.html.erb' => 'Constraints'
      allow(view).to receive(:search_action_url).and_return('/')
      allow(view).to receive(:params).and_return({q: 'foobar'})
      render
    end
    it 'should render headings' do
      rendered.should match('<h2.*?>Results summary</h2>')
    end
    it 'should render links to manuscripts, transcriptions and annotations' do
      expect(rendered).to have_css('form', count: 3)
      expect(rendered).to have_css('form button', count: 3)
    end
    it 'should render links to manuscripts' do
      expect(rendered).to have_css('input#search_field_descriptions_1[value=descriptions]')
      expect(rendered).to have_css('input#q_descriptions_1[value=foobar]')
      expect(rendered).to have_css('form button', text: '44 Manuscripts')
    end
    it 'should render links to transcriptions' do
      expect(rendered).to have_css('form button', text: '234 Transcriptions')
      expect(rendered).to have_css('input#q_transcriptions_1[value=foobar]')
      expect(rendered).to have_css('input#search_field_transcriptions_1[value=transcriptions]')
    end
    it 'should render links to annotations' do
      expect(rendered).to have_css('form button', text: '4 Annotations')
      expect(rendered).to have_css('input#q_annotations_1[value=foobar]')
      expect(rendered).to have_css('input#search_field_annotations_1[value=annotations]')
    end
  end
  describe 'it should not render form if no results' do
    before(:all) do
      @response_m = {'response' => {'numFound' => 44}}
      @response_t = {'response' => {'numFound' => 234}}
      @response_a = {'response' => {'numFound' => 0}}
    end
    it 'should render links to manuscripts and transcriptions' do
      expect(rendered).to have_css('form', count: 2)
      expect(rendered).to have_css('form button', count: 2)
    end
    it 'should render links to annotations' do
      expect(rendered).not_to have_css('form button', text: '0 Annotations')
      expect(rendered).not_to have_css('input#q_annotations_1[value=foobar]')
      expect(rendered).not_to have_css('input#search_field_annotations_1[value=annotations]')
      expect(rendered).to have_css('div', text: '0 Annotations')
    end
  end
end