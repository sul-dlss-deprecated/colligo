module JsonReader
  class Reader
    def from_str(str)
      JSON.parse(str)
    end

    def from_url(url, _encoding = nil)
      require 'open-uri'
      begin
        JSON.parse(open(url).read)
      rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, Errno::ETIMEDOUT, EOFError,
             Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError, OpenURI::HTTPError => the_error
        puts "\nOpen URI error for #{url}\n\t#{the_error.message}" # TODO: Add to log
        return nil
      end
    end

    # Read in the contents of a JSON record from a file.
    # @param filename (String) - path to file that has the annotations json as its content
    # @return Hash
    # @example
    #   foo = AnnotationData::Reader.new.from_file('/path/to/annotation/file.json')
    def from_file(filename, _encoding = nil)
      file = File.read(filename)
      JSON.parse(file)
    end
  end
end
