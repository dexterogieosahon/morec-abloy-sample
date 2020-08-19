Feature: Request messages
  As an API client
  I want to send messages to the endpoint
  So that i can make request that the server will accept and process

  Background:
    Given I send and accept JSON

  Scenario: Invalid structure with invalid request body
    When I send a POST request to "/" with the following:
    """
    {
      username: invalid_message,
      token: @1?Y
    }
    """
    Then the response status should be '400'
    And the invalid_json response body should contain:
    """
    {
      "error": {
        "code": "invalid_json",
        "message": "Invalid JSON payload.",
        "errors": {
          "cause": ["765: unexpected token at '{\n  username: invalid_message,\n  token: @1?Y\n}'"]
        }
      }
    }
    """
