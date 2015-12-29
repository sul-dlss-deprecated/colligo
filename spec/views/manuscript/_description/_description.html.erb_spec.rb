require 'spec_helper'

describe 'manuscript/_description/_description.html.erb' do
  include SolrDocumentFixtures
  it 'should render all the manuscript details' do
    @document = manuscript_docs[0]
    @document['title_other_display'] = ['Other title']
    @document['subtitle_display'] = 'Subtitle'
    @document['personal_authors_display'] = ['Author 1', 'Author 2']
    @document['authors_all_display'] = ['Author 1', 'Author 3', 'Author 4']
    @document['genre_display'] = ['genre 1', 'genre 2']
    @document['era_display'] = ['Early 1800s']
    @document['pub_date_display'] = ['1804 to 1834']
    @document['place_display'] = ['Great Britain']
    @document['physical_description_extent_display'] = ['120 pages']
    @document['physical_description_form_display'] = ['Papyrus']
    @document['physical_description_media_type_display'] = ['Scroll']
    @document['format'] = ['Format']
    @document['publishers_display'] = ['Publisher 1', 'Publisher 2']
    @document['access_condition_display'] = 'Access condition'
    render
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Alternate titles"]', text: 'Alternate title')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Evangelia<br/>Other title')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Subtitle"]', text: 'Subtitle')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Subtitle')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Corporate authors"]', text: 'Corporate authors')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'St Albans<br/>Canterbury')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Personal authors"]', text: 'Personal authors')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Author 1<br/>Author 2')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Other authors"]', text: 'Other authors')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Author 3<br/>Author 4')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Repository"]', text: 'Repository')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Parker Manuscripts')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Language"]', text: 'Language')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Latin.')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Topic"]', text: 'Topic')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Manuscripts')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Region"]', text: 'Region')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Great Britain')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Keyword"]', text: 'Keyword')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'genre 1<br/>genre 2')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Era"]', text: 'Era')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Early 1800s')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Date of publication"]', text: 'Date of publication')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: '1804 to 1834')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Location"]', text: 'Location')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Great Britain')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Extent"]', text: 'Extent')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: '120 pages')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Form"]', text: 'Form')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Papyrus')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Media type"]', text: 'Media type')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Scroll')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Publisher"]', text: 'Publisher')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Publisher 1<br/>Publisher 2')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Type of resource"]', text: 'Type of resource')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'manuscript<br/>text')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Format"]', text: 'Format')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Format')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Manuscript location"]', text: 'Manuscript location')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Parker Library, Corpus Christi College, Cambridge, UK')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Access condition"]', text: 'Access condition')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Access condition')
  end
  it 'should render available details' do
    @document = manuscript_docs[0]
    @document['title_other_display'] = []
    @document['personal_authors_display'] = []
    @document['authors_all_display'] = []
    @document['genre_display'] = []
    @document['era_display'] = []
    @document['place_display'] = []
    @document['physical_description_extent_display'] = []
    @document['physical_description_form_display'] = []
    @document['physical_description_media_type_display'] = []
    @document['format'] = []
    @document['publishers_display'] = []
    render
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Alternate titles"]', text: 'Alternate title')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Evangelia')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Subtitle"]', text: 'Subtitle')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Corporate authors"]', text: 'Corporate authors')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'St Albans<br/>Canterbury')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Personal authors"]', text: 'Personal authors')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Other authors"]', text: 'Other authors')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Repository"]', text: 'Repository')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Parker Manuscripts')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Language"]', text: 'Language')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Latin.')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Topic"]', text: 'Topic')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Manuscripts')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Region"]', text: 'Region')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Great Britain')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Keyword"]', text: 'Keyword')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Era"]', text: 'Era')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Date of publication"]', text: 'Date of publication')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Location"]', text: 'Location')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Extent"]', text: 'Extent')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Form"]', text: 'Form')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Media type"]', text: 'Media type')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Publisher"]', text: 'Publisher')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Type of resource"]', text: 'Type of resource')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'manuscript<br/>text')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Format"]', text: 'Format')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Manuscript location"]', text: 'Manuscript location')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Parker Library, Corpus Christi College, Cambridge, UK')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Access condition"]', text: 'Access condition')
  end
  it 'should render available details' do
    @document = manuscript_docs[9]
    @document['title_other_display'] = []
    @document['corporate_authors_display'] = []
    @document['authors_all_display'] = []
    @document['genre_display'] = []
    @document['topic_display'] = []
    @document['geographic_display'] = []
    @document['era_display'] = []
    @document['subject_all_display'] = []
    @document['place_display'] = []
    @document['physical_description_extent_display'] = []
    @document['physical_description_form_display'] = []
    @document['physical_description_media_type_display'] = []
    @document['publishers_display'] = []
    render
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Alternate titles"]', text: 'Alternate title')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Letter from Eusebius to Carpianus<br/>Canon tables<br/>Gospels<br/>Gospel Book')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Subtitle"]', text: 'Subtitle')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Corporate authors"]', text: 'Corporate authors')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Personal authors"]', text: 'Personal authors')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Eusebius, of Caesarea, Bishop of Caesarea, ca. 260-ca. 340.<br/>Cosmas, Indicopleustes, active 6th century')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Other authors"]', text: 'Other authors')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Repository"]', text: 'Repository')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'The Walters Art Museum')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Language"]', text: 'Language')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Greek, Ancient (t0 1453)')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Topic"]', text: 'Topic')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Region"]', text: 'Region')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Keyword"]', text: 'Keyword')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Era"]', text: 'Era')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Date of publication"]', text: 'Date of publication')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: '0900, 0950, ')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Location"]', text: 'Location')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Extent"]', text: 'Extent')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Form"]', text: 'Form')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Media type"]', text: 'Media type')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Publisher"]', text: 'Publisher')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Type of resource"]', text: 'Type of resource')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'manuscript<br/>mixed material')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Format"]', text: 'Format')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Manuscript/Archive')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Manuscript location"]', text: 'Manuscript location')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'The Walters Art Museum, 600 North Charles Street, Baltimore MD 21201.')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Access condition"]', text: 'Access condition')
    expect(rendered).to have_css('dl.dl-horizontal dd', text: 'Licensed for use under Creative Commons Attribution-ShareAlike 3.0 Unported Access Rights, http://creativecommons.org/licenses/by-sa/3.0/legalcode. Images are free for any use, provided you follow the terms of this license. You do not need to apply to the Walters prior to using the images. We ask only that you cite the source of the images as the Walters Art Museum (see citation style at http://www.thedigitalwalters.org/03_ReadMe.html). Additionally, we request that a copy of any work created using these materials be sent to the Curator of Manuscripts and Rare Books at the Walters Art Museum, 600 N. Charles Street, Baltimore, MD 21201, mss-curator@thewalters.org.All Walters manuscript images and descriptions provided here are copyrighted © The Walters Art Museum.CC by-sa: Attribution-ShareAlike 3.0 Unported')
  end
end
