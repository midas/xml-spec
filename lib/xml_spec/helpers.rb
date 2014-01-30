#require "multi_json"

module XmlSpec
  module Helpers

    extend self

    def parse_xml( xml, path=nil )
      Nokogiri::XML( xml ) { |config| config.options = Nokogiri::XML::ParseOptions::STRICT }
      parser = Nori.new
      ruby = parser.parse( xml )
      value_at_json_path( ruby, path )
    rescue Nokogiri::XML::SyntaxError=> e
      raise XmlSpec::XmlSyntaxError.new( e )
    end

    def normalize_xml( xml, path=nil )
      Nokogiri.XML( xml ) do |config|
        config.default_xml.noblanks
      end.to_xml( indent: 2 ).chomp
    end

    # TODO consider removing ths method as we do not need 2 levels with XML
    def generate_normalized_xml( xml_or_hash )
      xml = nil
      if xml_or_hash.is_a?( Hash )
         hash = xml_or_hash
         raise 'error' if hash.keys.size != 1
         root = hash.keys.first
         xml = hash[root].to_xml( root: root )
      end

      normalize_xml( xml )
    end

    def load_xml(relative_path)
      missing_json_directory! if XmlSpec.directory.nil?
      path = File.join(XmlSpec.directory, relative_path)
      missing_xml_file!(path) unless File.exist?(path)
      File.read(path)
    end

  private

    def value_at_json_path(ruby, path)
      return ruby unless path

      path.split("/").inject(ruby) do |value, key|
        case value
        when Hash
          value.fetch(key){ missing_json_path!(path) }
        when Array
          missing_json_path!(path) unless key =~ /^\d+$/
          value.fetch(key.to_i){ missing_json_path!(path) }
        else
          missing_json_path!(path)
        end
      end
    end

    def missing_json_path!(path)
      raise XmlSpec::MissingPath.new(path)
    end

    def missing_xml_directory!
      raise XmlSpec::MissingDirectory
    end

    def missing_xml_file!(path)
      raise XmlSpec::MissingFile.new(path)
    end
  end

end
