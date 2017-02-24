require 'rails_helper'

describe '/catalog/_bentopage/_annotations.html.erb' do
  include SolrDocumentFixtures
  describe 'it should render annotations' do
    before(:all) do
      # TODO: Using transcription results as there are no annotation results
      @response_a = annotation_resp
      @document_list_a = annotation_docs
    end
    before(:each) do
      stub_template 'shared/_annotation.html.erb' => '<span>Each annotation</span>'
      allow(view).to receive(:search_action_url).and_return('/')
      allow(view).to receive(:params).and_return(q: 'gospel')
      render
    end
    it 'should render headings' do
      expect(rendered).to match('<h2.*?>Annotations</h2>')
    end
    it 'should render links to annotations' do
      expect(rendered).to have_css('form', count: 1)
      expect(rendered).to have_css('form button', count: 1)
      expect(rendered).to have_css('input#search_field_annotations[value=annotations]', visible: false)
      expect(rendered).to have_css('input#q_annotations[value=gospel]', visible: false)
      expect(rendered).to have_css('h4 span.glyphicon-forward')
      expect(rendered).to have_css('form button', text: "See all #{@response_a['response']['numFound']}")
    end
    it 'should render 6 annotation partials' do
      expect(rendered).to have_css('span', text: 'Each annotation', count: 6)
    end
  end
  describe 'it should display heading if no results' do
    before(:all) do
      @response_a = annotation_resp_002
      @document_list_a = annotation_docs_002
    end
    before(:each) do
      stub_template 'shared/_annotation.html.erb' => '<span>Each annotation</span>'
      allow(view).to receive(:search_action_url).and_return('/')
      allow(view).to receive(:params).and_return(q: 'foobar')
      render
    end
    it 'should render headings' do
      expect(rendered).to match('<h2.*?>Annotations</h2>')
    end
    it 'should render no results text and no links' do
      expect(rendered).not_to have_css('form')
      expect(rendered).to have_css('h4', text: ' No results')
    end
    it 'should not render any annotation partials' do
      expect(rendered).not_to have_css('span', text: 'Each annotation')
    end
  end
end
