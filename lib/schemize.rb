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
        {
          'items' => {
            'type' => 'array',
            'properties' => schemize(obj.first)
          }
        }
      when Hash
        {
          'items' => {
            'type' => 'object',
            'properties' => obj.inject({}) {|h, (k, v)|
              h[k] = {
                'description' => k,
                'type' => schemize(v)
              }
              h
            }
          }
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
      when nil
        nil
      else
        'object'
      end
    end
  end
end
