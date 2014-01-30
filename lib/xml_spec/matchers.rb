require "xml_spec/matchers/be_xml_eql"
#require "xml_spec/matchers/include_xml"
#require "xml_spec/matchers/have_xml_path"
#require "xml_spec/matchers/have_xml_type"
#require "xml_spec/matchers/have_xml_size"

module XmlSpec
  module Matchers

    def be_xml_eql( xml=nil )
      XmlSpec::Matchers::BeXmlEql.new( xml )
    end

    #def include_xml(xml = nil)
      #XmlSpec::Matchers::IncludeJson.new(xml)
    #end

    #def have_xml_path(path)
      #XmlSpec::Matchers::HaveJsonPath.new(path)
    #end

    #def have_xml_type(type)
      #XmlSpec::Matchers::HaveJsonType.new(type)
    #end

    #def have_xml_size(size)
      #XmlSpec::Matchers::HaveJsonSize.new(size)
    #end

  end
end

RSpec.configure do |config|
  config.include XmlSpec::Matchers
end
