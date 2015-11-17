module AnnotationData
  extend ActiveSupport::Concern
  
  attr_accessor :annotationjson
  
  def annotation
    return nil unless self[:annotationjson]
    @annotation = Reader.new.from_str(self[:annotationjson])
  end
  
  class Reader
    def from_str(str)
      @annotation = JSON.parse(str)
    end
    
    def from_url(url, encoding = nil)
      require 'open-uri'
      @annotation = JSON.parse(open(url).read)
    end

    # Read in the contents of a JSON record from a file.
    # @param filename (String) - path to file that has the annotations json as its content
    # @return Hash
    # @example
    #   foo = AnnotationData::Reader.new.from_file('/path/to/annotation/file.json')
    def from_file(filename, encoding = nil)
      file = File.read(filename)
      @annotation = JSON.parse(file)
    end
    
  end
  
end
