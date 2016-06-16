require 'spec_helper'

class AnnotationDataTestClass
  include AnnotationData
end

describe AnnotationData do
  include AnnotationFixtures
  before(:all) do
    @document = SolrDocument.new
    response1 = File.open("#{::Rails.root}/spec/fixtures/annotation_records/annotation_001.json").read
    stub_request(:get, annotation_url_001)
      .with(headers: { 'Accept' => '*/*', 'User-Agent' => 'Ruby' })
      .to_return(status: 200, body: response1, headers: {})
    @annotation_list = @document.read_annotation(annotation_url_001)
    @document_with_id = SolrDocument.new(druid: 'kq131cs7229',
                                         collection: 'Parker collection',
                                         iiif_manifest: 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/manifest.json',
                                         mods_url: 'https://purl.stanford.edu/kq131cs7229.mods')
  end

  describe '#read_annotation' do
    it 'should be nil if no annotation url' do
      expect(SolrDocument.new.read_annotation).to be_nil
    end

    it 'should be a Hash' do
      expect(@annotation_list).to be_a Hash
    end

    it 'should have the keys @context, @id, @type and resources' do
      expect(@annotation_list.keys).to eq(%w(@context @id @type resources))
    end

    it 'should have an array of resources' do
      expect(@annotation_list['resources']).to be_a Array
    end

    it 'should have 19 annotations' do
      expect(@annotation_list['resources'].length).to eq 19
    end

    it 'should have the first annotation equal annotation_001' do
      expect(@annotation_list['resources'].first).to eq(annotation_001)
    end
  end

  describe '#motivation_for_annotations' do
    it 'should be a String' do
      expect(@document.motivation_for_annotations).to be_a String
      expect(SolrDocument.new.motivation_for_annotations).to be_a String
    end

    it 'should be equal to oa:commenting' do
      expect(@document.motivation_for_annotations).to eq 'oa:commenting'
      expect(SolrDocument.new.motivation_for_annotations).to eq 'oa:commenting'
    end
  end

  describe '#motivation_for_transcriptions' do
    it 'should be a String' do
      expect(@document.motivation_for_transcriptions).to be_a String
      expect(SolrDocument.new.motivation_for_transcriptions).to be_a String
    end

    it 'should be equal to sc:painting' do
      expect(@document.motivation_for_transcriptions).to eq 'sc:painting'
      expect(SolrDocument.new.motivation_for_transcriptions).to eq 'sc:painting'
    end
  end

  describe '#resources' do
    it 'should be an Array' do
      expect(@document.resources(@annotation_list)).to be_a Array
      expect(SolrDocument.new.resources).to be_a Array
    end

    it 'should be empty if no annotation url' do
      expect(SolrDocument.new.resources).to be_empty
    end

    it 'should have 19 resources' do
      expect(@document.resources(@annotation_list).length).to eq 19
    end
  end

  describe '#annotations' do
    it 'should be an Array' do
      expect(@document.annotations(@annotation_list)).to be_a Array
      expect(SolrDocument.new.annotations).to be_a Array
    end

    it 'should be empty if no annotation url' do
      expect(SolrDocument.new.annotations).to be_empty
    end

    it 'should have no annotations' do
      expect(@document.annotations(@annotation_list).length).to eq 0
    end
  end

  describe '#transcriptions' do
    it 'should be an Array' do
      expect(@document.transcriptions(@annotation_list)).to be_a Array
      expect(SolrDocument.new.transcriptions).to be_a Array
    end

    it 'should be empty if no annotation url' do
      expect(SolrDocument.new.transcriptions).to be_empty
    end

    it 'should have 19 transcriptions' do
      expect(@document.transcriptions(@annotation_list).length).to eq 19
    end

    it 'should have the first transcription equal annotation_001' do
      expect(@document.transcriptions(@annotation_list).first).to eq(annotation_001)
    end
  end

  describe '#map_annotation' do
    let(:anno_doc_1) { @document.map_annotation(annotation_001) }
    let(:anno_doc_2) { @document.map_annotation(annotation_002) }
    it 'should be an Hash' do
      expect(anno_doc_1).to be_a Hash
      expect(SolrDocument.new.map_annotation).to be_a Hash
    end

    it 'should be empty if no annotation url' do
      expect(SolrDocument.new.map_annotation).to be_empty
    end

    it 'should be empty if no annotation url' do
      expect(anno_doc_1).not_to be_empty
    end

    it 'should have the keys id, motivation, target_type, target_url, body_type, body_format, body_chars and body_language, model' do
      expect(anno_doc_1.keys).to eq(%w(id target_type motivation target_url body_type body_format body_chars body_language model))
    end

    it 'should be human language and not iso code' do
      expect(anno_doc_1['body_language']).to eq 'Latin'
    end

    it 'should be iso code for language if not in list' do
      expect(anno_doc_2['body_language']).to eq 'fle'
    end
  end

  describe '#annotation_to_solr' do
    let(:solr_doc_all) { @document_with_id.annotation_to_solr(solr_data_all) }
    let(:solr_doc_anno) { @document_with_id.annotation_to_solr(solr_data_anno) }
    let(:solr_doc_no_id) { @document.annotation_to_solr(solr_data_no_id) }
    let(:solr_doc_no_anno) { @document.annotation_to_solr(solr_data_no_anno) }

    it 'should be a empty hash if no annotation url' do
      expect(SolrDocument.new.annotation_to_solr).to eq({})
    end

    it 'should return a Hash' do
      expect(solr_doc_all).to be_a Hash
      expect(solr_doc_anno).to be_a Hash
      expect(solr_doc_no_id).to be_a Hash
      expect(solr_doc_no_anno).to be_a Hash
    end

    it 'should be a empty hash if no annotation data' do
      expect(solr_doc_no_anno).to eq({})
    end

    it 'should be a empty hash if no id' do
      expect(solr_doc_no_id).to eq({})
    end

    it 'should not be a empty hash with id' do
      expect(solr_doc_all).to_not eq({})
      expect(solr_doc_anno).to_not eq({})
    end

    it 'should have an id' do
      expect(solr_doc_all).to have_key('id')
      expect(solr_doc_all['id']).to eq('_:N43deaea09a5345379218db8cb72600c3')
      expect(solr_doc_anno).to have_key('id')
      expect(solr_doc_anno['id']).to eq('_:Nec72601c72094655ae7b0df521dd3e7f')
    end

    it 'should have an druid' do
      expect(solr_doc_all).to have_key('druid')
      expect(solr_doc_all['druid']).to eq('kq131cs7229')
      expect(solr_doc_anno['druid']).to eq('kq131cs7229')
    end

    it 'should have a body chars' do
      expect(solr_doc_all).to have_key('body_chars_search')
      expect(solr_doc_all['body_chars_search']).to eq('Erant aut[em] qui manducaverant')
      expect(solr_doc_anno['body_chars_search']).to eq('-sei et ceper[un]t conquirere cu[m] eo que-')
    end

    it 'should have collection' do
      expect(solr_doc_all).to have_key('collection')
      expect(solr_doc_all['collection']).to eq('Parker collection')
      expect(solr_doc_anno['collection']).to eq('Parker collection')
    end

    it 'should have manifest url' do
      expect(solr_doc_all).to have_key('manifest_urls')
      expect(solr_doc_all['manifest_urls']).to eq('http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/manifest.json')
      expect(solr_doc_anno['manifest_urls']).to eq('http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/manifest.json')
    end

    it 'should have manuscript if defined' do
      expect(solr_doc_all).to have_key('manuscript_search')
      expect(solr_doc_all['manuscript_search']).to eq('Manuscript fragment of the Gospels and Canonical Epistles, glossed')
      expect(solr_doc_anno).not_to have_key('manuscript_search')
    end

    it 'should have url if defined' do
      expect(solr_doc_all).to have_key('url_sfx')
      expect(solr_doc_all['url_sfx']).to eq('http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/list/text-f8r.json')
      expect(solr_doc_anno).not_to have_key('url_sfx')
    end

    it 'should have folio if defined' do
      expect(solr_doc_all).to have_key('folio')
      expect(solr_doc_all['folio']).to eq('f. 8r')
      expect(solr_doc_anno).not_to have_key('folio')
    end

    it 'should have img_info if defined' do
      expect(solr_doc_all).to have_key('img_info')
      expect(solr_doc_all['img_info']).to eq(['http://stacks.stanford.edu/image/kq131cs7229/sulmss_misc305_008r_SM'])
      expect(solr_doc_anno).not_to have_key('img_info')
    end

    it 'should have model Transcription' do
      expect(solr_doc_all).to have_key('model')
      expect(solr_doc_all['model']).to eq('Transcription')
      expect(solr_doc_anno['model']).to eq('Transcription')
    end
  end
end
