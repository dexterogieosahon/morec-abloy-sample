# frozen_string_literal: true

Then(/^the response data should have "([^"]*)" items$/) do |count|
  expect(response_data).to have_exactly(count).items
end
