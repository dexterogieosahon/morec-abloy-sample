# frozen_string_literal: true

Then(/^the response body should be OK$/) do
  expect(last_response.body).to eq('OK')
end