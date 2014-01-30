module XmlSpec

  class Error < StandardError
  end

  class XmlSyntaxError < Error
    def initialize( e=nil )
      super e
      set_backtrace e.backtrace if e
    end

    def to_s
      "Invalid XML"
    end
  end

  class MissingPath < Error
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def to_s
      %(Missing JSON path "#{path}")
    end
  end

  class MissingDirectory < Error
    def to_s
      "No XmlSpec.directory set"
    end
  end

  class MissingFile < Error
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def to_s
      "No XML file at #{path}"
    end
  end

end
