require "spec_helper"

describe XmlSpec::Helpers do

  include described_class

  let :xml do
    %(<xml><specs type="array"><spec type="integer">1</spec><spec type="integer">2</spec></specs></xml>)
  end

  let :normalized do
    <<-XML
<?xml version="1.0"?>
<xml>
  <specs type="array">
    <spec type="integer">1</spec>
    <spec type="integer">2</spec>
  </specs>
</xml>
    XML
  end

  let :hash do
    {"xml" => {"specs" =>  [1, 2]}}
  end

  context "parse_xml" do

    it "parses XML documents" do
      parse_xml( xml ).should == hash
    end

    it "raises a parser error for invalid XML" do
      expect{ parse_xml("xml_spec") }.to raise_error( XmlSpec::XmlSyntaxError )
    end

    it "parses at a path if given" do
      parse_xml( xml, "xml/specs" ).should == [1, 2]
      parse_xml( xml, "xml/specs/0" ).should == 1
    end

    it "raises an error for a missing path" do
      %w(spec spec/1).each do |path|
        expect{ parse_xml( xml, path ) }.to raise_error( XmlSpec::MissingPath )
      end
    end

  end

  context "normalize_xml" do

    it "normalizes a XML document" do
      normalize_xml( xml ).should == normalized.chomp
    end

    #it "normalizes at a path" do
      #normalize_xml(%({"xml":["spec"]}), "xml/0").should == %("spec")
    #end

    #it "accepts a XML value" do
      #normalize_xml(%("xml_spec")).should == %("xml_spec")
    #end

    #it "normalizes XML values" do
      #normalize_xml(%(1e+1)).should == %(10.0)
    #end

  end

  context "generate_normalized_xml" do

    it "generates a normalized XML document" do
      generate_normalized_xml( hash ).should == normalized.chomp
    end

    it "generates a normalized XML value" do
      generate_normalized_xml( nil ).should == %(<?xml version=\"1.0\"?>)
    end

  end

  #context "load_xml_file" do
    #it "raises an error when no directory is set" do
      #expect{ load_xml("one.xml") }.to raise_error(XmlSpec::MissingDirectory)
    #end

    #it "returns JSON when the file exists" do
      #XmlSpec.directory = files_path
      #load_xml("one.xml").should == %({"value":"from_file"})
    #end

    #it "ignores extra slashes" do
      #XmlSpec.directory = "/#{files_path}/"
      #load_xml("one.xml").should == %({"value":"from_file"})
    #end

    #it "raises an error when the file doesn't exist" do
      #XmlSpec.directory = files_path
      #expect{ load_xml("bogus.xml") }.to raise_error(XmlSpec::MissingFile)
    #end

    #it "raises an error when the directory doesn't exist" do
      #XmlSpec.directory = "#{files_path}_bogus"
      #expect{ load_xml("one.xml") }.to raise_error(XmlSpec::MissingFile)
    #end

    #it "finds nested files" do
      #XmlSpec.directory = files_path
      #load_xml("project/one.xml").should == %({"nested":"inside_folder"})
      #load_xml("project/version/one.xml").should == %({"nested":"deeply"})
    #end
  #end

end
