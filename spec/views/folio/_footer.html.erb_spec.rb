require 'rails_helper'

describe '/folio/_footer.html.erb' do
  describe 'display for all form factors but extra small' do
    before(:each) do
      stub_template 'folio/_previous_folio.html.erb' => '<div>Previous</div>'
      stub_template 'shared/_manuscript_body.html.erb' => '<div>Manuscript body</div>'
      stub_template 'folio/_next_folio.html.erb' => '<div>Next</div>'
      allow(view).to receive(:current_or_guest_user).and_return(true)
      render
    end
    it 'should display the media div' do
      expect(rendered).to have_css('div.media.hidden-xs', count: 1)
      expect(rendered).to have_css('div.media.hidden-xs div:nth-child(1).media-left')
      expect(rendered).to have_css('div.media.hidden-xs div:nth-child(2).media-body.media-body-center')
      expect(rendered).to have_css('div.media.hidden-xs div:nth-child(3).media-right')
    end
    it 'should display the previous folio' do
      expect(rendered).to have_css('div.media-left div', text: 'Previous')
    end
    it 'should display the manuscript details' do
      expect(rendered).to have_css('div.media-body.media-body-center div.panel.panel-content.folio-panel div.panel-body div', text: 'Manuscript body')
    end
    it 'should display the next folio' do
      expect(rendered).to have_css('div.media-right div', text: 'Next')
    end
  end
  describe 'display for extra small form factor' do
    before(:each) do
      stub_template 'folio/_previous_folio.html.erb' => '<div>Previous</div>'
      stub_template 'shared/_manuscript_body.html.erb' => '<div>Manuscript body</div>'
      stub_template 'folio/_next_folio.html.erb' => '<div>Next</div>'
      allow(view).to receive(:current_or_guest_user).and_return(true)
      render
    end
    it 'should display the media div' do
      expect(rendered).to have_css('div.visible-xs.row', count: 1)
      expect(rendered).to have_css('div.visible-xs.row div.col-xs-12', count: 3)
      expect(rendered).to have_css('div.visible-xs.row div:nth-child(1).col-xs-12 div', text: 'Previous')
      expect(rendered).to have_css('div.visible-xs.row div:nth-child(2).col-xs-12 div.panel.panel-content.folio-panel')
      expect(rendered).to have_css('div.visible-xs.row div:nth-child(3).col-xs-12 div', text: 'Next')
    end
    it 'should display the previous folio' do
      expect(rendered).to have_css('div.visible-xs.row div:nth-child(1).col-xs-12 div', text: 'Previous')
    end
    it 'should display the manuscript details' do
      expect(rendered).to have_css('div.col-xs-12 div.panel.panel-content.folio-panel div.panel-body div', text: 'Manuscript body')
    end
    it 'should display the next folio' do
      expect(rendered).to have_css('div.visible-xs.row div:nth-child(3).col-xs-12 div', text: 'Next')
    end
  end
end
