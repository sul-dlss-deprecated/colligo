require 'rails_helper'

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
    expect(rendered).to have_css('dl.dl-horizontal dt', count: 21)
    expect(rendered).to have_css('dl.dl-horizontal dd', count: 21)
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Alternate titles"]:nth-child(1)', text: 'Alternate title')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(2)') do |t|
      expect(t.text).to include('Evangelia<br/>Other title')
    end
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Subtitle"]:nth-child(3)', text: 'Subtitle')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(4)', text: 'Subtitle')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Corporate authors"]:nth-child(5)', text: 'Corporate authors')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(6)') do |t|
      expect(t.text).to include('St Albans<br/>Canterbury')
    end
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Personal authors"]:nth-child(7)', text: 'Personal authors')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(8)') do |t|
      expect(t.text).to include('Author 1<br/>Author 2')
    end
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Other authors"]:nth-child(9)', text: 'Other authors')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(10)') do |t|
      expect(t.text).to include('Author 3<br/>Author 4')
    end
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Repository"]:nth-child(11)', text: 'Repository')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(12)', text: 'Parker Manuscripts')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Language"]:nth-child(13)', text: 'Language')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(14)', text: 'Latin.')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Topic"]:nth-child(15)', text: 'Topic')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(16)', text: 'Manuscripts')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Region"]:nth-child(17)', text: 'Region')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(18)', text: 'Great Britain')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Keyword"]:nth-child(19)', text: 'Keyword')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(20)') do |t|
      expect(t.text).to include('genre 1<br/>genre 2')
    end
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Era"]:nth-child(21)', text: 'Era')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(22)', text: 'Early 1800s')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Date of publication"]:nth-child(23)', text: 'Date of publication')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(24)', text: '1804 to 1834')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Location"]:nth-child(25)', text: 'Location')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(26)', text: 'Great Britain')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Extent"]:nth-child(27)', text: 'Extent')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(28)', text: '120 pages')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Form"]:nth-child(29)', text: 'Form')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(30)', text: 'Papyrus')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Media type"]:nth-child(31)', text: 'Media type')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(32)', text: 'Scroll')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Format"]:nth-child(33)', text: 'Format')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(34)', text: 'Format')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Publisher"]:nth-child(35)', text: 'Publisher')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(36)') do |t|
      expect(t.text).to include('Publisher 1<br/>Publisher 2')
    end
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Type of resource"]:nth-child(37)', text: 'Type of resource')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(38)') do |t|
      expect(t.text).to include('manuscript<br/>text')
    end
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Manuscript location"]:nth-child(39)', text: 'Manuscript location')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(40)', text: 'Parker Library, Corpus Christi College, Cambridge, UK')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Access condition"]:nth-child(41)', text: 'Access condition')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(42)', text: 'Access condition')
  end
  it 'should render available details 1' do
    @document = manuscript_docs[0]
    @document['title_other_display'] = []
    @document['personal_authors_display'] = []
    @document['authors_all_display'] = ['St Albans', 'Canterbury']
    @document['genre_display'] = []
    @document['era_display'] = []
    @document['place_display'] = []
    @document['physical_description_extent_display'] = []
    @document['physical_description_form_display'] = []
    @document['physical_description_media_type_display'] = []
    @document['format'] = []
    @document['publishers_display'] = []
    render
    expect(rendered).to have_css('dl.dl-horizontal dt', count: 8)
    expect(rendered).to have_css('dl.dl-horizontal dd', count: 8)
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Alternate titles"]:nth-child(1)', text: 'Alternate title')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(2)', text: 'Evangelia')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Subtitle"]', text: 'Subtitle')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Corporate authors"]:nth-child(3)', text: 'Corporate authors')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(4)') do |t|
      expect(t.text).to include('St Albans<br/>Canterbury')
    end
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Personal authors"]', text: 'Personal authors')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Other authors"]', text: 'Other authors')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Repository"]:nth-child(5)', text: 'Repository')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(6)', text: 'Parker Manuscripts')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Language"]:nth-child(7)', text: 'Language')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(8)', text: 'Latin.')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Topic"]:nth-child(9)', text: 'Topic')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(10)', text: 'Manuscripts')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Region"]:nth-child(11)', text: 'Region')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(12)', text: 'Great Britain')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Keyword"]', text: 'Keyword')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Era"]', text: 'Era')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Date of publication"]', text: 'Date of publication')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Location"]', text: 'Location')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Extent"]', text: 'Extent')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Form"]', text: 'Form')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Media type"]', text: 'Media type')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Publisher"]', text: 'Publisher')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Type of resource"]:nth-child(13)', text: 'Type of resource')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(14)') do |t|
      expect(t.text).to include('manuscript<br/>text')
    end
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Format"]', text: 'Format')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Manuscript location"]:nth-child(15)', text: 'Manuscript location')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(16)', text: 'Parker Library, Corpus Christi College, Cambridge, UK')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Access condition"]', text: 'Access condition')
  end
  it 'should render available details 2' do
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
    expect(rendered).to have_css('dl.dl-horizontal dt', count: 9)
    expect(rendered).to have_css('dl.dl-horizontal dd', count: 9)
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Alternate titles"]:nth-child(1)', text: 'Alternate title')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(2)') do |t|
      expect(t.text).to include('Letter from Eusebius to Carpianus<br/>Canon tables<br/>Gospels<br/>Gospel Book')
    end
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Subtitle"]', text: 'Subtitle')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Corporate authors"]', text: 'Corporate authors')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Personal authors"]:nth-child(3)', text: 'Personal authors')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(4)') do |t|
      expect(t.text).to include('Eusebius, of Caesarea, Bishop of Caesarea, ca. 260-ca. 340.<br/>Cosmas, Indicopleustes, active 6th century')
    end
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Other authors"]', text: 'Other authors')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Repository"]:nth-child(5)', text: 'Repository')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(6)', text: 'The Walters Art Museum')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Language"]:nth-child(7)', text: 'Language')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(8)', text: 'Greek, Ancient (t0 1453)')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Topic"]', text: 'Topic')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Region"]', text: 'Region')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Keyword"]', text: 'Keyword')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Era"]', text: 'Era')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Date of publication"]:nth-child(9)', text: 'Date of publication')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(10)', text: '0900, 0950, ')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Location"]', text: 'Location')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Extent"]', text: 'Extent')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Form"]', text: 'Form')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Media type"]', text: 'Media type')
    expect(rendered).not_to have_css('dl.dl-horizontal dt[title="Publisher"]', text: 'Publisher')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Format"]:nth-child(11)', text: 'Format')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(12)', text: 'Manuscript/Archive')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Type of resource"]:nth-child(13)', text: 'Type of resource')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(14)') do |t|
      expect(t.text).to include('manuscript<br/>mixed material')
    end
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Manuscript location"]:nth-child(15)', text: 'Manuscript location')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(16)', text: 'The Walters Art Museum, 600 North Charles Street, Baltimore MD 21201.')
    expect(rendered).to have_css('dl.dl-horizontal dt[title="Access condition"]:nth-child(17)', text: 'Access condition')
    expect(rendered).to have_css('dl.dl-horizontal dd:nth-child(18)') do |t|
      expect(t.text).to include('Licensed for use under Creative Commons Attribution-ShareAlike 3.0 Unported Access Rights, http://creativecommons.org/licenses/by-sa/3.0/legalcode. Images are free for any use, provided you follow the terms of this license. You do not need to apply to the Walters prior to using the images. We ask only that you cite the source of the images as the Walters Art Museum (see citation style at http://www.thedigitalwalters.org/03_ReadMe.html). Additionally, we request that a copy of any work created using these materials be sent to the Curator of Manuscripts and Rare Books at the Walters Art Museum, 600 N. Charles Street, Baltimore, MD 21201, mss-curator@thewalters.org.All Walters manuscript images and descriptions provided here are copyrighted © The Walters Art Museum.CC by-sa: Attribution-ShareAlike 3.0 Unported')
    end
  end
end
