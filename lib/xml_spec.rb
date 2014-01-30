#require "json"
#require 'active_support/all'
require 'active_support/core_ext/hash/conversions'
#require 'active_support/core_ext'
require 'equivalent-xml'
require 'nokogiri'
require 'nori'
require "rspec"
require "xml_spec/errors"
require "xml_spec/exclusion"
require "xml_spec/helpers"
require "xml_spec/messages"
require "xml_spec/matchers"

module XmlSpec

  autoload :Configuration, 'xml_spec/configuration'
  autoload :VERSION,       'xml_spec/version'

  extend Configuration

end

class Hash
  def diff(other)
    (self.keys + other.keys).uniq.inject({}) do |memo, key|
      unless self[key] == other[key]
        if self[key].kind_of?(Hash) &&  other[key].kind_of?(Hash)
          memo[key] = self[key].diff(other[key])
        else
          memo[key] = [self[key], other[key]]
        end
      end
      memo
    end
  end

  def interpret_diff( memos=[], path=[] )
    self.inject(memos) do |memo, key_value|
      k, v = key_value.first, key_value.last
      path << k
      #puts '', "memo: #{memo.inspect}", "key: #{k}", "value: #{v}"
      #puts "path: #{path.inspect}"
      if v.kind_of?( Hash )
        #debugger
        v.interpret_diff( memos, path )
      elsif v.kind_of?(Array)
        #debugger
        memo << "#{path.join( '/' )}: #{v.map { |val| val.nil? ? 'nil' : (val.respond_to?( :empty? ) && val.empty? ? "''" : "'#{val}'") }.join( ' is not ' )}"
      end
    end

    memos
  end

end
