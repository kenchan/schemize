require 'thor'

module Schemize
  class CLI < Thor
    default_command :convert

    desc 'convert', 'convert JSON to JSON Schema from STDIN'
    def convert
      converter = Converter.new

      hash = {'schema' => converter.perform(JSON.parse(STDIN.read))}

      puts hash.to_yaml
    end
  end
end
