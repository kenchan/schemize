require 'test/unit'
require 'schemize'

class CliTest < Test::Unit::TestCase
  def setup
    @cli =  Schemize::CLI.new
  end

  def test_simpole_object_json
    json = JSON.parse(<<-JSON)
      {
        "firstName": "Taro",
        "lastName":  "YAMADA",
        "age": 30
      }
    JSON

    schema = JSON.parse(<<-SCHEMA)
      {
        "type": "object",
        "properties": {
          "firstName": {
            "type": "string"
          },
          "lastName": {
            "type": "string"
          },
          "age": {
            "type": "integer"
          }
        }
      }
    SCHEMA

    assert { @cli.schemize(json) == schema }
  end
end
