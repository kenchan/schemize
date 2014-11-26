require "schemize/version"

require 'thor'
require 'json'
require 'yaml'

module Schemize
  class CLI < Thor
    default_command :convert

    desc 'convert', 'convert JSON to JSON Schema from STDIN'
    def convert
      hash = {
        'schema' => schemize(JSON.parse(STDIN.read))
      }

      puts hash.to_yaml
    end

    def schemize(obj)
      case obj
      when Array
        {
          'type' => 'array',
          'items' => obj.inject({}) {|h, i| h.merge(schemize(i)) }
        }
      when Hash
        {
          'type' => 'object',
          'properties' => obj.inject({}) {|h, (k, v)|
            h[k] = schemize(v)
            h
          }
        }
      else
        {'type' => detect_type(obj)}
      end
    end

    private

    def detect_type(value)
      case value
      when String
        'string'
      when Numeric
        'integer'
      when nil
        nil
      else
        'object'
      end
    end
  end
end
