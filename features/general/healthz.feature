Feature: Healthz
  As an API client
  I want to check the API is alive
  So that i can make future requests to it

  Scenario: Successful healthz check
    Given I send and accept plain text
    When I send a GET request to "/healthz"
    Then the response status should be '200'
    And the response body should be OK