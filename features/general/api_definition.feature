Feature: API Definition
  As an API client
  I want to check the API definition
  So that i can see the API's offering

  Background:
    Given I send and accept JSON

  Scenario: Successful API Definition check
    When I send a GET request to "/swagger.json"
    Then the response status should be '200'
    And the response body should have keys:
    """
      swagger info host basePath schemes consumes produces
      tags paths definitions
    """