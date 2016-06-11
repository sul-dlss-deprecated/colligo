require 'spec_helper'

describe '/catalog/_homepage/_home_modal.html.erb' do
  let(:f1) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Latin.', hits: '325') }
  let(:f2) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Latin', hits: '208') }
  let(:f3) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Persian', hits: '98') }
  let(:f4) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Arabic', hits: '61') }
  let(:f5) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Latin and English.', hits: '30') }
  let(:f6) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'No linguistic content. Not applicable.', hits: '25') }
  let(:f7) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Greek, Ancient (t0 1453)', hits: '22') }
  let(:f8) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Latin and Anglo-Norman.', hits: '21') }
  let(:f9) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Latin and Old English.', hits: '18') }
  let(:f10) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Old English and Latin.', hits: '14') }
  let(:f11) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Armenian', hits: '12') }
  let(:f12) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Geez', hits: '11') }
  let(:f13) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Middle English and Latin.', hits: '11') }
  let(:f14) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Turkish, Ottoman (1500-1928)', hits: '11') }
  let(:f15) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'Dutch', hits: '10') }
  let(:f16) { Blacklight::Solr::Response::Facets::FacetItem.new( value: 'English.', hits: '10') }
  let(:lang) do
    [Blacklight::Solr::Response::Facets::FacetField.new(
        'language',
        [f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16],
        options: {sort: 'count', limit: -1}
    )]
  end
  before(:each) do
    allow(view).to receive(:facet_field).and_return(double('key' => 'language'))
    allow(view).to receive(:facet_field_label).with('language').and_return('Facet label')
    allow(view).to receive(:display_facet).and_return(lang)
    allow(view).to receive(:render_refine_facet_limit).and_return(raw('<div class="rendered_refine_facet">Rendered refine facet</div>'))
    render
  end
  it 'should have a modal div' do
    expect(rendered).to have_css('div.modal', count: 1)
    expect(rendered).to have_css('div.modal div.modal-dialog', count: 1)
    expect(rendered).to have_css('div.modal div.modal-dialog div.modal-content', count: 1)
  end
  it 'should have a modal header' do
    expect(rendered).to have_css('div.modal-content div.modal-header', count: 1)
  end
  it 'should have a close button' do
    expect(rendered).to have_css('div.modal-header button.close', count: 1, text: '×')
  end
  it 'should have a title' do
    expect(rendered).to have_css('div.modal-header h3.modal-title', count: 1, text: 'Facet label')
  end
  it 'should have a modal body' do
    expect(rendered).to have_css('div.modal-content div.modal-body', count: 1)
  end
  it 'should have the facets' do
    expect(rendered).to have_css('div.modal-body div.facet_extended_list', count: 1)
  end
  it 'should render the facet' do
    expect(rendered).to have_css('div.modal-body div.facet_extended_list div.rendered_refine_facet', count: 1, text: 'Rendered refine facet')
  end
  it 'should have a modal footer' do
    expect(rendered).to have_css('div.modal-content div.modal-footer', count: 1)
  end
end