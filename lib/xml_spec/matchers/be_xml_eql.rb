module XmlSpec
  module Matchers
    class BeXmlEql

      include XmlSpec::Helpers
      include XmlSpec::Exclusion
      include XmlSpec::Messages

      attr_reader :expected, :actual

      def diffable?
        true
      end

      def initialize( expected_xml=nil )
        @expected_xml = expected_xml
      end

      def matches?( actual_xml )
        raise "Expected equivalent XML not provided" if @expected_xml.nil?

        @actual_xml = actual_xml
        @actual = parse_xml( actual_xml, @path )
        @expected = parse_xml( @expected_xml, @path )
        #@actual, @expected = scrub(actual_xml, @path), scrub(@expected_xml)
        #@actual == @expected
        EquivalentXml.equivalent?( @expected_xml, @actual_xml )
      end

      def at_path(path)
        @path = path
        self
      end

      def to_file(path)
        @expected_xml = load_xml(path)
        self
      end

      def excluding(*keys)
        excluded_keys.merge(keys.map(&:to_s))
        self
      end

      def including(*keys)
        excluded_keys.subtract(keys.map(&:to_s))
        self
      end

      def failure_message_for_should
        message_with_path( "Expected equivalent XML" ) #+ "\nReadable Diff:\n#{diff}"
      end

      def failure_message_for_should_not
        message_with_path( "Expected inequivalent XML" )
      end

      def description
        message_with_path("equal XML")
      end

    private

      def diff
        '  ' + expected.diff( actual ).interpret_diff.join( "\n  " )
      end

      def scrub(xml, path = nil)
        generate_normalized_xml(exclude_keys(parse_xml(xml, path))).chomp + "\n"
      end

    end
  end
end
