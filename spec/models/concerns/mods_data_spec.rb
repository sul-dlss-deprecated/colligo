require 'spec_helper'

class ModsDataTestClass
  include ModsData
end

describe ModsData do
  include ModsFixtures
  let(:document) { SolrDocument.new(modsxml: dms_mods_001) }
  let(:document_with_id) do
    SolrDocument.new(modsxml: dms_mods_001,
                     druid: 'fh878gz0315',
                     collection: 'Parker collection',
                     iiif_manifest: 'http://dms-data.stanford.edu/data/manifests/Parker/fh878gz0315/manifest.json',
                     mods_url: 'https://purl.stanford.edu/fh878gz0315.mods')
  end
  let(:document_with_id2) do
    SolrDocument.new(modsxml: dms_mods_002,
                     druid: 'kq131cs7229',
                     thumbnail: 'https://stacks.stanford.edu/image/iiif/kq131cs7229%2Fsulmss_misc305_008r_SM/full/!400,400/0/default.jpg')
  end
  let(:document_with_id4) do
    SolrDocument.new(modsxml: dms_mods_004,
                     druid: 'mr892jv0716',
                     thumbnail: 'https://stacks.stanford.edu/image/iiif/mr892jv0716%2Fmr892jv0716_05_0001/full/!400,400/0/default.jpg')
  end
  let(:document_with_id5) do
    SolrDocument.new(modsxml: dms_mods_005,
                     druid: 'kh686yw0435',
                     collection: 'Stanford University Libraries',
                     iiif_manifest: 'http://dms-data.stanford.edu/data/manifests/Stanford/kh686yw0435/manifest.json',
                     mods_url: 'https://purl.stanford.edu/kh686yw0435.mods',
                     thumbnail: 'https://stacks.stanford.edu/image/iiif/kh686yw0435%2Fkh686yw0435_0001/full/!400,400/0/default.jpg')
  end
  let(:document_with_id8) do
    SolrDocument.new(modsxml: dms_mods_008,
                     druid: 'tw490xj0071',
                     thumbnail: 'https://stacks.stanford.edu/image/iiif/tw490xj0071%2Ftw490xj0071_05_0001/full/!400,400/0/default.jpg')
  end
  let(:document_with_id11) do
    SolrDocument.new(modsxml: dms_mods_011,
                     druid: 'rc145sy7436',
                     thumbnail: 'https://stacks.stanford.edu/image/iiif/rc145sy7436%2F1019926/full/!400,400/0/default.jpg')
  end

  describe '#mods' do
    it 'should be nil if no modsxml' do
      expect(SolrDocument.new.mods).to be_nil
    end

    it 'should be a ModsDisplay' do
      expect(document.mods).to be_a ModsDisplay::HTML
      expect(document_with_id.mods).to be_a ModsDisplay::HTML
      expect(document_with_id2.mods).to be_a ModsDisplay::HTML
      expect(document_with_id4.mods).to be_a ModsDisplay::HTML
      expect(document_with_id5.mods).to be_a ModsDisplay::HTML
      expect(document_with_id8.mods).to be_a ModsDisplay::HTML
      expect(document_with_id11.mods).to be_a ModsDisplay::HTML
    end
  end

  describe '#mods_raw' do
    it 'should be nil if no modsxml' do
      expect(SolrDocument.new.mods_raw).to be_nil
    end

    it 'should be a ModsDisplay' do
      expect(document.mods_raw).to be_a Stanford::Mods::Record
      expect(document_with_id.mods_raw).to be_a Stanford::Mods::Record
      expect(document_with_id2.mods_raw).to be_a Stanford::Mods::Record
      expect(document_with_id4.mods_raw).to be_a Stanford::Mods::Record
      expect(document_with_id5.mods_raw).to be_a Stanford::Mods::Record
      expect(document_with_id8.mods_raw).to be_a Stanford::Mods::Record
      expect(document_with_id11.mods_raw).to be_a Stanford::Mods::Record
    end

    it 'should have title' do
      expect(document.mods_raw.sort_title).to eq('Old English Homilies, mostly by Ælfric')
      expect(document_with_id.mods_raw.sort_title).to eq('Old English Homilies, mostly by Ælfric')
      expect(document_with_id2.mods_raw.sort_title).to eq('Manuscript fragment of the Gospels and Canonical Epistles, glossed')
      expect(document_with_id4.mods_raw.sort_title).to eq('Acquittance')
      expect(document_with_id5.mods_raw.sort_title).to eq('Fragment from a Beneventan Psalter')
      expect(document_with_id8.mods_raw.sort_title).to eq("Commentary on the 'De Sensu et Sensato' : manuscript fragment")
      expect(document_with_id11.mods_raw.sort_title).to eq('Yale University, Beinecke Rare Book and Manuscript Library, MS 229 - Arthurian Romances')
    end

    it 'should have alternative title' do
      expect(document.mods_raw.alternative_titles).to eq(['Homiliae Saxonicae (IV)'])
      expect(document_with_id.mods_raw.alternative_titles).to eq(['Homiliae Saxonicae (IV)'])
      expect(document_with_id2.mods_raw.alternative_titles).to eq([])
      expect(document_with_id4.mods_raw.alternative_titles).to eq(['Stanford University Libraries, M0299'])
      expect(document_with_id5.mods_raw.alternative_titles).to eq(['Stanford University Libraries, M0389'])
      expect(document_with_id8.mods_raw.alternative_titles).to eq([])
      expect(document_with_id11.mods_raw.alternative_titles).to eq([])
    end
  end

  describe '#prettified_mods' do
    it 'should be nil if no modsxml' do
      expect(SolrDocument.new.prettified_mods).to be_nil
    end

    it 'should return prettified mods' do
      expect(document.prettified_mods).to be_a String
      expect(document.prettified_mods).to match /<div class="CodeRay">/
      expect(document.prettified_mods).to match />Old English Homilies, mostly by Ælfric</
      expect(document_with_id5.prettified_mods).to be_a String
      expect(document_with_id5.prettified_mods).to match /<div class="CodeRay">/
      expect(document_with_id5.prettified_mods).to match />Fragment from a Beneventan Psalter</
    end
  end

  describe '#mods_to_solr' do
    let(:data) { document.mods_to_solr }
    let(:data_with_id) { document_with_id.mods_to_solr }
    let(:data_with_id2) { document_with_id2.mods_to_solr }
    let(:data_with_id4) { document_with_id4.mods_to_solr }
    let(:data_with_id5) { document_with_id5.mods_to_solr }
    let(:data_with_id8) { document_with_id8.mods_to_solr }
    let(:data_with_id11) { document_with_id11.mods_to_solr }
    it 'should be a empty hash if no modsxml' do
      expect(SolrDocument.new.mods_to_solr).to eq({})
    end

    it 'should return a Hash' do
      expect(data).to be_a Hash
      expect(data_with_id).to be_a Hash
      expect(data_with_id2).to be_a Hash
      expect(data_with_id4).to be_a Hash
      expect(data_with_id5).to be_a Hash
      expect(data_with_id8).to be_a Hash
      expect(data_with_id11).to be_a Hash
    end

    it 'should be a empty hash if no id' do
      expect(data).to eq({})
    end

    it 'should not be a empty hash with id' do
      expect(data_with_id).to_not eq({})
      expect(data_with_id2).to_not eq({})
      expect(data_with_id4).to_not eq({})
      expect(data_with_id5).to_not eq({})
      expect(data_with_id8).to_not eq({})
      expect(data_with_id11).to_not eq({})
    end

    it 'should have an id' do
      expect(data_with_id).to have_key('id')
      expect(data_with_id['id']).to eq('fh878gz0315')
      expect(data_with_id2['id']).to eq('kq131cs7229')
      expect(data_with_id4['id']).to eq('mr892jv0716')
      expect(data_with_id5['id']).to eq('kh686yw0435')
      expect(data_with_id8['id']).to eq('tw490xj0071')
      expect(data_with_id11['id']).to eq('rc145sy7436')
    end

    it 'should have an druid' do
      expect(data_with_id).to have_key('druid')
      expect(data_with_id['druid']).to eq('fh878gz0315')
      expect(data_with_id2['druid']).to eq('kq131cs7229')
      expect(data_with_id4['druid']).to eq('mr892jv0716')
      expect(data_with_id5['druid']).to eq('kh686yw0435')
      expect(data_with_id8['druid']).to eq('tw490xj0071')
      expect(data_with_id11['druid']).to eq('rc145sy7436')
    end

    it 'should have an abstract' do
      expect(data_with_id).to have_key('abstract_search')
      expect(data_with_id['abstract_search']).to eq('')
      expect(data_with_id2['abstract_search']).to eq('')
      expect(data_with_id4['abstract_search']).to eq("Acquittance for a thousand livres tournois for the despense de l'hostel du Roy notre sire.")
      expect(data_with_id5['abstract_search']).to eq("Fragment from a Beneventan psalter, containing most of Psalm 36: verses 1-29. For an early printed edition of this text in its relation to other versions of the psalter, see Jacques Lefevre d'Etaples's Quincuplex Psalterium, 1513. ")
      expect(data_with_id8['abstract_search']).to eq("From a university text book. The manuscript frequently cites Aristotle and \"sensus et sensibilis\" (the little treatise of Aristotle is sometimes called \"De sensu et Sensibili). Besides sensation the fragment mentions motion, form, intellect, and odour. [dealer description]")
      expect(data_with_id11['abstract_search']).to eq('Lavishly illuminated manuscript consisting of 77 large column miniatures, 51
            smaller miniatures, and 36 historiated initials. Miniatures and historiated initials by
            at least two artists, the scale and quality of whose work distinguish the manuscript
            from contemporary and most fourteenth-century Arthurian manuscripts.')
    end

    it 'should have an access condition' do
      expect(data_with_id).to have_key('access_condition_search')
      expect(data_with_id['access_condition_search']).to eq('')
      expect(data_with_id2['access_condition_search']).to eq('Property rights reside with the repository. Literary rights reside with the creators of the documents or their heirs. To obtain permission to publish or reproduce, please contact the Special Collections Public Services Librarian at speccollref@stanford.edu.')
      expect(data_with_id4['access_condition_search']).to eq('Property rights reside with the repository. Literary rights reside with the creators of the documents or their heirs. To obtain permission to publish or reproduce, please contact the Special Collections Public Services Librarian at speccollref@stanford.edu.')
      expect(data_with_id5['access_condition_search']).to eq('Property rights reside with the repository. Literary rights reside with the creators of the documents or their heirs. To obtain permission to publish or reproduce, please contact the Special Collections Public Services Librarian at speccollref@stanford.edu.')
      expect(data_with_id8['access_condition_search']).to eq('Property rights reside with the repository. Literary rights reside with the creators of the documents or their heirs. To obtain permission to publish or reproduce, please contact the Special Collections Public Services Librarian at speccollref@stanford.edu.')
      expect(data_with_id11['access_condition_search']).to eq('Property rights reside with the repository. Literary rights reside with the creators of the documents or their heirs. To obtain permission to publish or reproduce, please contact the Special Collections Public Services Librarian at speccollref@stanford.edu.')
    end

    it 'should have genre' do
      expect(data_with_id).to have_key('genre_search')
      expect(data_with_id['genre_search']).to eq([])
      expect(data_with_id2['genre_search']).to eq([])
      expect(data_with_id4['genre_search']).to eq([])
      expect(data_with_id5['genre_search']).to eq([])
      expect(data_with_id8['genre_search']).to eq(['Manuscripts, latin (medieval and modern)-england.'])
      expect(data_with_id11['genre_search']).to eq(['Illuminated manuscripts', 'Miniatures (illuminations)', 'Illustrations', 'Historiated initials', 'Hand coloring'])
    end

    it 'should have type of resource' do
      expect(data_with_id).to have_key('type_of_resource_search')
      expect(data_with_id['type_of_resource_search']).to eq(%w(manuscript text))
      expect(data_with_id2['type_of_resource_search']).to eq([''])
      expect(data_with_id4['type_of_resource_search']).to eq(['mixed material'])
      expect(data_with_id5['type_of_resource_search']).to eq(['mixed material'])
      expect(data_with_id8['type_of_resource_search']).to eq(['text'])
      expect(data_with_id11['type_of_resource_search']).to eq(['text'])
    end

    it 'should have corporate authors' do
      expect(data_with_id).to have_key('corporate_authors_search')
      expect(data_with_id['corporate_authors_search']).to eq(['Worcester'])
      expect(data_with_id2['corporate_authors_search']).to eq([])
      expect(data_with_id4['corporate_authors_search']).to eq([])
      expect(data_with_id5['corporate_authors_search']).to eq([])
      expect(data_with_id8['corporate_authors_search']).to eq([])
      expect(data_with_id11['corporate_authors_search']).to eq([])
    end

    it 'should have person authors' do
      expect(data_with_id).to have_key('personal_authors_search')
      expect(data_with_id['personal_authors_search']).to eq([])
      expect(data_with_id2['personal_authors_search']).to eq([])
      expect(data_with_id4['personal_authors_search']).to eq([])
      expect(data_with_id5['personal_authors_search']).to eq([])
      expect(data_with_id8['personal_authors_search']).to eq(['Aristotle.'])
      expect(data_with_id11['personal_authors_search']).to eq([])
    end

    it 'should have all authors' do
      expect(data_with_id).to have_key('authors_all_search')
      expect(data_with_id['authors_all_search']).to eq(['Worcester'])
      expect(data_with_id2['authors_all_search']).to eq([])
      expect(data_with_id4['authors_all_search']).to eq([])
      expect(data_with_id5['authors_all_search']).to eq([])
      expect(data_with_id8['authors_all_search']).to eq(['Aristotle.'])
      expect(data_with_id11['authors_all_search']).to eq([])
    end

    it 'should have a title' do
      expect(data_with_id).to have_key('title_search')
      expect(data_with_id['title_search']).to eq('Old English Homilies, mostly by Ælfric')
      expect(data_with_id2['title_search']).to eq('Manuscript fragment of the Gospels and Canonical Epistles, glossed')
      expect(data_with_id4['title_search']).to eq('Acquittance')
      expect(data_with_id5['title_search']).to eq('Fragment from a Beneventan Psalter')
      expect(data_with_id8['title_search']).to eq("Commentary on the 'De Sensu et Sensato' : manuscript fragment")
      expect(data_with_id11['title_search']).to eq('Yale University, Beinecke Rare Book and Manuscript Library, MS 229 - Arthurian Romances')
    end

    it 'should have alternate titles' do
      expect(data_with_id).to have_key('title_alternate_search')
      expect(data_with_id['title_alternate_search']).to eq(['Homiliae Saxonicae (IV)'])
      expect(data_with_id2['title_alternate_search']).to eq([])
      expect(data_with_id4['title_alternate_search']).to eq(['Stanford University Libraries, M0299'])
      expect(data_with_id5['title_alternate_search']).to eq(['Stanford University Libraries, M0389'])
      expect(data_with_id8['title_alternate_search']).to eq([])
      expect(data_with_id11['title_alternate_search']).to eq([])
    end

    it 'should have other titles' do
      expect(data_with_id).to have_key('title_other_search')
      expect(data_with_id['title_other_search']).to eq([])
      expect(data_with_id2['title_other_search']).to eq(['Bible'])
      expect(data_with_id4['title_other_search']).to eq([])
      expect(data_with_id5['title_other_search']).to eq([])
      expect(data_with_id8['title_other_search']).to eq([])
      expect(data_with_id11['title_other_search']).to eq([])
    end

    it 'is a pending field - subittle'

    it 'should have language' do
      expect(data_with_id).to have_key('language')
      expect(data_with_id['language']).to eq(['Old English and Latin.'])
      expect(data_with_id2['language']).to eq(['Latin'])
      expect(data_with_id4['language']).to eq([])
      expect(data_with_id5['language']).to eq(['Latin'])
      expect(data_with_id8['language']).to eq(['Latin'])
      # expect(data_with_id11["language"]).to eq(["French"]) #TODO this is not being picked
    end

    it 'is a pending field - physical description extent'

    it 'is a pending field - physical description form'

    it 'is a pending field - physical description media type'

    it 'should have physical location' do
      expect(data_with_id).to have_key('physical_location_display')
      expect(data_with_id['physical_location_display']).to eq(['Parker Library, Corpus Christi College, Cambridge, UK'])
      expect(data_with_id2['physical_location_display']).to eq(['Department of Special Collections, Stanford University Libraries, Stanford, CA 94305'])
      expect(data_with_id4['physical_location_display']).to eq(['Stanford University. Libraries. Department of Special Collections and University Archives',
                                                                'M0299. Box  3, Folder  2, Item  082'])
      expect(data_with_id5['physical_location_display']).to eq(['Stanford University. Libraries. Department of Special Collections and University Archives',
                                                                'M0389. Box 1, Folder 05'])
      expect(data_with_id8['physical_location_display']).to eq(['Department of Special Collections, Stanford University Libraries, Stanford, CA 94305'])
      expect(data_with_id11['physical_location_display']).to eq(['General Collection, Beinecke Rare Book and Manuscript Library, Yale
                University'])
    end

    it 'is a pending field - physical location url'

    it 'is a pending field - related item location url'

    it 'is a pending field - related item title'

    it 'should have publication dates' do
      expect(data_with_id).to have_key('pub_dates')
      expect(data_with_id['pub_dates']).to be_nil
      expect(data_with_id2['pub_dates']).to eq(['1135'])
      expect(data_with_id4['pub_dates']).to eq(['1389'])
      expect(data_with_id5['pub_dates']).to eq(%w(850 1499))
      expect(data_with_id8['pub_dates']).to eq(['14uu'])
      expect(data_with_id11['pub_dates']).to eq(['s. XIII^^ex [ca. 1275-1300]'])
    end

    it 'should have all publication years' do
      expect(data_with_id).to have_key('pub_date')
      expect(data_with_id['pub_date']).to eq([])
      expect(data_with_id2['pub_date']).to eq([1135])
      expect(data_with_id4['pub_date']).to eq([1389])
      expect(data_with_id5['pub_date']).to eq([850, 1499])
      expect(data_with_id8['pub_date']).to eq([1400, 1499])
      expect(data_with_id11['pub_date']).to eq([1275, 1300])
    end

    it 'should have single publication date for sorting' do
      expect(data_with_id).to have_key('pub_date_sort')
      expect(data_with_id['pub_date_sort']).to be_empty
      expect(data_with_id2['pub_date_sort']).to eq(1135)
      expect(data_with_id4['pub_date_sort']).to eq(1389)
      expect(data_with_id5['pub_date_sort']).to eq(1174)
      expect(data_with_id8['pub_date_sort']).to eq(1449)
      expect(data_with_id11['pub_date_sort']).to eq(1287)
    end

    it 'should have publication date in display form' do
      expect(data_with_id).to have_key('pub_date_display')
      expect(data_with_id['pub_date_display']).to be_empty
      expect(data_with_id2['pub_date_display']).to eq('1135')
      expect(data_with_id4['pub_date_display']).to eq('1389')
      expect(data_with_id5['pub_date_display']).to eq('850 to 1499')
      expect(data_with_id8['pub_date_display']).to eq('14uu')
      expect(data_with_id11['pub_date_display']).to eq('s. XIII^^ex [ca. 1275-1300]')
    end

    it 'should have a topic' do
      expect(data_with_id).to have_key('topic_search')
      expect(data_with_id['topic_search']).to eq(['Manuscripts'])
      expect(data_with_id2['topic_search']).to eq(['Bible', 'History', 'Manuscripts, Latin', 'Church history'])
      expect(data_with_id4['topic_search']).to be_nil
      expect(data_with_id5['topic_search']).to be_nil
      expect(data_with_id8['topic_search']).to eq(['Manuscripts, Latin (Medieval and modern)-England.', 'Senses and sensation'])
      expect(data_with_id11['topic_search']).to eq(['Illuminated manuscripts', 'Miniatures (Illuminations)', 'Illustrations',
                                                    'Historiated initials', 'Hand coloring'])
    end

    it 'should have region' do
      expect(data_with_id).to have_key('geographic_search')
      expect(data_with_id['geographic_search']).to eq(['Great Britain'])
      expect(data_with_id2['geographic_search']).to eq(['France'])
      expect(data_with_id4['geographic_search']).to be_nil
      expect(data_with_id5['geographic_search']).to be_nil
      expect(data_with_id8['geographic_search']).to be_nil
      expect(data_with_id11['geographic_search']).to be_nil
    end

    it 'should have era' do
      expect(data_with_id).to have_key('era_search')
      expect(data_with_id['era_search']).to be_nil
      expect(data_with_id2['era_search']).to eq(['Middle Ages, 987-1515'])
      expect(data_with_id4['era_search']).to be_nil
      expect(data_with_id5['era_search']).to be_nil
      expect(data_with_id8['era_search']).to be_nil
      expect(data_with_id11['era_search']).to be_nil
    end

    it 'should have other subjects' do
      expect(data_with_id).to have_key('subject_other_search')
      expect(data_with_id['subject_other_search']).to be_nil
      expect(data_with_id2['subject_other_search']).to eq(['of Laon, Anselm, d.1117', 'of Laon, Ralph, d.1133'])
      expect(data_with_id4['subject_other_search']).to be_nil
      expect(data_with_id5['subject_other_search']).to be_nil
      expect(data_with_id8['subject_other_search']).to eq(['Aristotle'])
      expect(data_with_id11['subject_other_search']).to be_nil
    end

    it 'should have all subjects' do
      expect(data_with_id).to have_key('subject_all_search')
      expect(data_with_id['subject_all_search']).to eq(['Manuscripts', 'Great Britain'])
      expect(data_with_id2['subject_all_search']).to eq(['Bible', 'History', 'Manuscripts, Latin', 'Church history',
                                                         'France', 'of Laon, Anselm, d.1117', 'of Laon, Ralph, d.1133', 'Middle Ages, 987-1515', 'Sources'])
      expect(data_with_id4['subject_all_search']).to be_nil
      expect(data_with_id5['subject_all_search']).to be_nil
      expect(data_with_id8['subject_all_search']).to eq(['Manuscripts, Latin (Medieval and modern)-England.',
                                                         'Senses and sensation', 'Aristotle', 'Early works to 1800'])
      expect(data_with_id11['subject_all_search']).to eq(['Illuminated manuscripts', 'Miniatures (Illuminations)',
                                                          'Illustrations', 'Historiated initials', 'Hand coloring'])
    end

    it 'should have a collection' do
      expect(data_with_id).to have_key('collection')
      expect(data_with_id['collection']).to eq('Parker collection')
      expect(data_with_id5).to have_key('collection')
      expect(data_with_id5['collection']).to eq('Stanford University Libraries')
    end

    it 'should have manifest url' do
      expect(data_with_id).to have_key('manifest_urls')
      expect(data_with_id['manifest_urls']).to eq('http://dms-data.stanford.edu/data/manifests/Parker/fh878gz0315/manifest.json')
      expect(data_with_id5).to have_key('manifest_urls')
      expect(data_with_id5['manifest_urls']).to eq('http://dms-data.stanford.edu/data/manifests/Stanford/kh686yw0435/manifest.json')
    end

    it 'should have url' do
      expect(data_with_id).to have_key('url_sfx')
      expect(data_with_id['url_sfx']).to eq('https://purl.stanford.edu/fh878gz0315.mods')
      expect(data_with_id5).to have_key('url_sfx')
      expect(data_with_id5['url_sfx']).to eq('https://purl.stanford.edu/kh686yw0435.mods')
    end

    it 'should have model Manuscript' do
      expect(data_with_id).to have_key('model')
      expect(data_with_id['model']).to eq('Manuscript')
      expect(data_with_id5['model']).to eq('Manuscript')
    end

    it 'should have a img_info' do
      expect(data_with_id).to have_key('img_info')
      expect(data_with_id2).to have_key('img_info')
      expect(data_with_id4).to have_key('img_info')
      expect(data_with_id5).to have_key('img_info')
      expect(data_with_id8).to have_key('img_info')
      expect(data_with_id11).to have_key('img_info')
      expect(data_with_id['img_info']).to be_nil
      expect(data_with_id2['img_info']).to eq('https://stacks.stanford.edu/image/iiif/kq131cs7229%2Fsulmss_misc305_008r_SM/full/!400,400/0/default.jpg')
      expect(data_with_id4['img_info']).to eq('https://stacks.stanford.edu/image/iiif/mr892jv0716%2Fmr892jv0716_05_0001/full/!400,400/0/default.jpg')
      expect(data_with_id5['img_info']).to eq('https://stacks.stanford.edu/image/iiif/kh686yw0435%2Fkh686yw0435_0001/full/!400,400/0/default.jpg')
      expect(data_with_id8['img_info']).to eq('https://stacks.stanford.edu/image/iiif/tw490xj0071%2Ftw490xj0071_05_0001/full/!400,400/0/default.jpg')
      expect(data_with_id11['img_info']).to eq('https://stacks.stanford.edu/image/iiif/rc145sy7436%2F1019926/full/!400,400/0/default.jpg')
    end
  end

  describe '#parse dates' do
    let(:dates1) { document.send(:parse_dates, nil) }
    let(:dates2) { document.send(:parse_dates, ['1389']) }
    let(:dates3) { document.send(:parse_dates, %w(850 1499)) }
    let(:dates4) { document.send(:parse_dates, ['Ca. 1580 CE']) }
    let(:dates5) { document.send(:parse_dates, ['1500 CE']) }
    let(:dates6) { document.send(:parse_dates, ['14uu']) }
    let(:dates7) { document.send(:parse_dates, ['February 6, 1486']) }
    let(:dates8) { document.send(:parse_dates, ['June 1781']) }
    let(:dates9) { document.send(:parse_dates, ['s. XIII^^ex [ca. 1275-1300]']) }
    it 'should be a hash' do
      expect(dates1).to be_a Hash
      expect(dates2).to be_a Hash
      expect(dates3).to be_a Hash
      expect(dates4).to be_a Hash
      expect(dates5).to be_a Hash
      expect(dates6).to be_a Hash
      expect(dates7).to be_a Hash
      expect(dates8).to be_a Hash
      expect(dates9).to be_a Hash
    end

    it 'should have the keys all_int, sort' do
      expect(dates1.keys).to eq([:all_int, :sort])
      expect(dates2.keys).to eq([:all_int, :sort])
      expect(dates3.keys).to eq([:all_int, :sort])
      expect(dates4.keys).to eq([:all_int, :sort])
      expect(dates5.keys).to eq([:all_int, :sort])
      expect(dates6.keys).to eq([:all_int, :sort])
      expect(dates7.keys).to eq([:all_int, :sort])
      expect(dates8.keys).to eq([:all_int, :sort])
      expect(dates9.keys).to eq([:all_int, :sort])
    end

    it 'should be an array for all_int' do
      expect(dates1[:all_int]).to be_a Array
      expect(dates2[:all_int]).to be_a Array
      expect(dates3[:all_int]).to be_a Array
      expect(dates4[:all_int]).to be_a Array
      expect(dates5[:all_int]).to be_a Array
      expect(dates6[:all_int]).to be_a Array
      expect(dates7[:all_int]).to be_a Array
      expect(dates8[:all_int]).to be_a Array
      expect(dates9[:all_int]).to be_a Array
    end

    it 'should be an array of all integer dates' do
      expect(dates1[:all_int]).to be_empty
      expect(dates2[:all_int]).to eq([1389])
      expect(dates3[:all_int]).to eq([850, 1499])
      expect(dates4[:all_int]).to eq([1580])
      expect(dates5[:all_int]).to eq([1500])
      expect(dates6[:all_int]).to eq([1400, 1499])
      expect(dates7[:all_int]).to eq([1486])
      expect(dates8[:all_int]).to eq([1781])
      expect(dates9[:all_int]).to eq([1275, 1300])
    end

    it 'should be an integer year for sort' do
      expect(dates1[:sort]).to be_empty
      expect(dates2[:sort]).to be_a Integer
      expect(dates3[:sort]).to be_a Integer
      expect(dates4[:sort]).to be_a Integer
      expect(dates5[:sort]).to be_a Integer
      expect(dates6[:sort]).to be_a Integer
      expect(dates7[:sort]).to be_a Integer
      expect(dates8[:sort]).to be_a Integer
      expect(dates9[:sort]).to be_a Integer
    end

    it 'should be the average integer year for sort' do
      expect(dates1[:sort]).to be_empty
      expect(dates2[:sort]).to eq(1389)
      expect(dates3[:sort]).to eq(1174)
      expect(dates4[:sort]).to eq(1580)
      expect(dates5[:sort]).to eq(1500)
      expect(dates6[:sort]).to eq(1449)
      expect(dates7[:sort]).to eq(1486)
      expect(dates8[:sort]).to eq(1781)
      expect(dates9[:sort]).to eq(1287)
    end
  end

  describe '#display date' do
    let(:date1) { document.send(:display_date, nil) }
    let(:date2) { document.send(:display_date, ['1389']) }
    let(:date3) { document.send(:display_date, %w(850 1499)) }
    let(:date4) { document.send(:display_date, ['Ca. 1580 CE']) }
    let(:date5) { document.send(:display_date, ['1500 CE']) }
    let(:date6) { document.send(:display_date, ['14uu']) }
    let(:date7) { document.send(:display_date, ['February 6, 1486']) }
    let(:date8) { document.send(:display_date, ['June 1781']) }
    let(:date9) { document.send(:display_date, ['s. XIII^^ex [ca. 1275-1300]']) }
    let(:date10) { document.send(:display_date, ['850', '1499', '']) }
    it 'should be a string' do
      expect(date1).to be_a String
      expect(date2).to be_a String
      expect(date3).to be_a String
      expect(date4).to be_a String
      expect(date5).to be_a String
      expect(date6).to be_a String
      expect(date7).to be_a String
      expect(date8).to be_a String
      expect(date9).to be_a String
      expect(date10).to be_a String
    end

    it 'should be the combined years for display' do
      expect(date1).to eq('')
      expect(date2).to eq('1389')
      expect(date3).to eq('850 to 1499')
      expect(date4).to eq('Ca. 1580 CE')
      expect(date5).to eq('1500 CE')
      expect(date6).to eq('14uu')
      expect(date7).to eq('February 6, 1486')
      expect(date8).to eq('June 1781')
      expect(date9).to eq('s. XIII^^ex [ca. 1275-1300]')
      expect(date10).to eq('850 to 1499')
    end
  end

  describe '#all_display_fields' do
    it 'should include all display fields' do
      expect(document.all_display_fields).to be_a Array
      expect(document.all_display_fields.length).to eq(29)
    end
  end

  describe '#single_valued_display_fields' do
    it 'should include all single valued display fields' do
      expect(document.single_valued_display_fields).to be_a Array
      expect(document.single_valued_display_fields.length).to eq(5)
    end
  end
end
