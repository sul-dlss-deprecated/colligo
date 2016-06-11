# encoding: UTF-8
module AnnotationFixtures
  def annotation_url_001
    'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/list/text-f8r.json'
  end

  def annotation_list_001
    File.open("#{::Rails.root}/spec/fixtures/annotation_records/annotation_001.json").read
  end

  def annotation_001
    {
      '@id' => '_:N43deaea09a5345379218db8cb72600c3',
      '@type' => 'oa:Annotation',
      'motivation' => 'sc:painting',
      'resource' =>
      {
        '@id' => '7377e5fe51c46454bb01b62a817a4d42',
        '@type' => 'cnt:ContentAsText',
        'format' => 'text/plain',
        'chars' => 'Erant aut[em] qui manducaverant',
        'language' => 'lat'
      },
      'on' => 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/canvas/canvas-3#xywh=600,450,1017,166'
    }
  end

  def annotation_002
    {
      '@id' => '_:Nec72601c72094655ae7b0df521dd3e7f',
      '@type' => 'oa:Annotation',
      'motivation' => 'sc:painting',
      'resource' =>
      {
        '@id' => '61574db3e19725509b692c3a099e0bc7',
        '@type' => 'cnt:ContentAsText',
        'format' => 'text/plain',
        'chars' => '-sei et ceper[un]t conquirere cu[m] eo que-',
        'language' => 'fle'
      },
      'on' => 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/canvas/canvas-3#xywh=600,1274,1017,153'
    }
  end

  def solr_data_all
    {
      'annotation' => annotation_001,
      'manuscript' => 'Manuscript fragment of the Gospels and Canonical Epistles, glossed',
      'folio' => 'f. 8r',
      'url' => 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/list/text-f8r.json',
      'img_info' => ['http://stacks.stanford.edu/image/kq131cs7229/sulmss_misc305_008r_SM']
    }
  end

  def solr_data_anno
    {
      'annotation' => annotation_002
    }
  end

  def solr_data_no_id
    {
      'annotation' => annotation_001.except('@id'),
      'manuscript' => 'Manuscript fragment of the Gospels and Canonical Epistles, glossed',
      'folio' => 'f. 8r',
      'url' => 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/list/text-f8r.json',
      'img_info' => ['http://stacks.stanford.edu/image/kq131cs7229/sulmss_misc305_008r_SM']
    }
  end

  def solr_data_no_anno
    {
      'manuscript' => 'Manuscript fragment of the Gospels and Canonical Epistles, glossed',
      'folio' => 'f. 8r',
      'url' => 'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/list/text-f8r.json',
      'img_info' => ['http://stacks.stanford.edu/image/kq131cs7229/sulmss_misc305_008r_SM']
    }
  end
end
