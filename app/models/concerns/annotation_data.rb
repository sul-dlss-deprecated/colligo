module AnnotationData
  include JsonReader
  extend ActiveSupport::Concern
  
  attr_accessor :annotationjson
  
  def annotation
    return nil unless self[:annotationjson]
    @annotation = JsonReader::Reader.new.from_str(self[:annotationjson])
  end
  
end
