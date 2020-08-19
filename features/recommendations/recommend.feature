Feature: Movie recommendation
  Provides movie suggestions for a user based on their movie genre preference

  Scenario: Unknown genre
    When I send a GET request to "/recommendations?genre=unknown"
    Then the response status should be '200'
    And the response body should be:
    """
    {
      "data": []
    }
    """
  Scenario: Known genre
    When I send a GET request to "/recommendations?genre=comedy"
    Then the response status should be '200'
    And the response data should have "1" items