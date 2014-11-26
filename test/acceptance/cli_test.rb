require 'test/unit'
require 'schemize'

class CliTest < Test::Unit::TestCase
  def setup
    @cli =  Schemize::CLI.new
  end

  def test_simple_json_object
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

  def test_simpole_json_array
    json = JSON.parse(<<-JSON)
      [
        {
          "firstName": "Taro",
          "lastName":  "YAMADA",
          "age": 30
        },
        {
          "firstName": "Hanako",
          "lastName":  "YAMADA",
          "age": 30
        }
      ]
    JSON

    schema = JSON.parse(<<-SCHEMA)
      {
        "type": "array",
        "items": {
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
      }
    SCHEMA

    assert { @cli.schemize(json) == schema }
  end

  def test_complex_json_object
    json = JSON.parse(<<-JSON)
      {
        "users": [
          {
            "firstName": "Taro",
            "lastName":  "YAMADA",
            "friend_ids": [2, 3]
          },
          {
            "firstName": "Hanako",
            "lastName":  "YAMADA",
            "age": 23,
            "friend_ids": [2, 3]
          }
        ]
      }
    JSON

    schema = JSON.parse(<<-SCHEMA)
      {
        "type": "object",
        "properties": {
          "users": {
            "type": "array",
            "items": {
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
                },
                "friend_ids": {
                  "type": "array",
                  "items": {
                    "type": "integer"
                  }
                }
              }
            }
          }
        }
      }
    SCHEMA

    assert { @cli.schemize(json) == schema }
  end
end
