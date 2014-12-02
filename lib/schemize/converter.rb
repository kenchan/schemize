require 'json'
require 'yaml'

module Schemize
  class Converter
    def perform(json)
      case json
      when Array
        {
          'type' => 'array',
          'items' => json.inject({}) {|h, i| h.merge(perform(i)) }
        }
      when Hash
        {
          'type' => 'object',
          'properties' => json.inject({}) {|h, (k, v)|
            h[k] = perform(v)
            h
          }
        }
      else
        {'type' => detect_type(json)}
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
