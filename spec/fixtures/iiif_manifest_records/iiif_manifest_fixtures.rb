# encoding: UTF-8
require 'json'
module IiifManifestFixtures
  def manifest_url_001
    'http://dms-data.stanford.edu/data/manifests/Stanford/kq131cs7229/manifest.json'
  end

  def manifest_url_002
    'http://dms-data.stanford.edu/data/manifests/BnF/jr903ng8662/manifest.json'
  end

  def manifest_url_003
    'http://dms-data.stanford.edu/data/manifests/Parker/fh878gz0315/manifest.json'
  end

  def manifest_url_004
    'https://purl.stanford.edu/bb389yg4719/iiif/manifest.json'
  end

  def manifest_csv_file
    "#{::Rails.root}/spec/fixtures/iiif_manifest_records/stub_manifest_urls.csv"
  end

  def manifest_contents
    JSON.parse(File.read('spec/fixtures/iiif_manifest_records/manifest_contents.json'))
  end
end
