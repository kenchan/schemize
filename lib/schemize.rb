require "schemize/version"

require 'thor'
require 'json'
require 'yaml'

module Schemize
  class CLI < Thor
    default_command :convert

    desc 'convert', 'convert JSON to JSON Schema from STDIN'
    def convert
      puts schemize(JSON.parse(STDIN.read)).to_yaml
    end

    private

    def stdin
      STDIN.read
    end

    def schemize(obj)
      case obj
      when Array
        obj.map {|o| schemize(o) }
      when Hash
        obj.inject({}) {|h, (k, v)|
          h[k] = schemize(v)
          h
        }
      else
        detect_type(obj)
      end
    end

    def detect_type(value)
      case value
      when String
        'string'
      when Numeric
        'integer'
      else
        'unknown'
      end
    end
  end
end
