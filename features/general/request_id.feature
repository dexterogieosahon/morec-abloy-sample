Feature: Request Id
  As an API client
  I want to have request id in my responses
  So that i can correlate the responses to requests

  Scenario: Request without request_id
    And I set header "Request-Id" with value ""
    When I send a GET request to "/"
    Then the response status should be '200'
    And the response should have header "Request-Id" with a value

  Scenario: Request with preset request_id
    And I set header "Request-Id" with value "sample-request-id"
    When I send a GET request to "/"
    Then the response status should be '200'
    And the response should have header "Request-Id" with value "sample-request-id"
