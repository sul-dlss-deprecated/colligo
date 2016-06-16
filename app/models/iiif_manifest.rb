# Model for iiif manifest
class IiifManifest
  include IiifManifestData

  def initialize(manifest_url = nil)
    self.manifest_url = manifest_url if manifest_url
  end
end
