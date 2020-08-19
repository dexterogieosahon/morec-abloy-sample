Feature: Routing
  The API should handle request routing to appropriate endpoints

  Scenario: Unknown route
    When I send a GET request to "/unknown-endpoint"
    Then the response status should be '404'
    And the response body should be:
    """
    {
      "error": {
        "code": "unknown_endpoint",
        "message": "Endpoint 'GET - /unknown-endpoint' not found."
      }
    }
    """
  Scenario: Known route
    When I send a GET request to "/"
    Then the response status should be '200'
    And the response body should be:
    """
    {
      "data": {
        "message": "Movie API"
      }
    }
    """
