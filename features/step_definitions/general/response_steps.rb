# frozen_string_literal: true

Then(/^the response should have header "([^"]*)" with value "([^"]*)"$/) do |key, value|
  expect(response_headers).to include(key => value)
end

Then(/^the response should have header "([^"]*)" with a value$/) do |key|
  expect(response_headers).to include(key => a_kind_of(String))
end

Then(/^the response header should include keys:$/) do |string|
  expected = string.split(' ').map(&:strip)
  expect(response_headers.keys).to include(*expected)
end

Then(/^the response status should be '(\d+)'$/) do |status|
  expect(response_status).to eq(status.to_i)
rescue RSpec::Expectations::ExpectationNotMetError => e
  puts 'Response body: '
  puts last_response.body
  raise e
end

Then(/^the response body should be:$/) do |string_body|
  expect(last_response.body).to be_json_eql(string_body)
end

Then(/^the invalid_json response body should contain:$/) do |_string_body|
  expected =
    {
      error: {
        code: 'invalid_json',
        message: 'Invalid JSON payload.',
        errors: {
          cause: [a_kind_of(String)]
        }
      }
    }
  expect(response_body).to include(expected)
end

Then(/^the response data at "([^"]*)" should be "([^"]*)"$/) do |data_path, value|
  idx, key = data_path.split('/')
  idx = idx.to_i
  expect(response_data[idx][key.to_sym]).to eql(value)
end

Then(/^the response data at "([^"]*)" should be boolean "([^"]*)"$/) do |data_path, value|
  idx, key = data_path.split('/')
  idx = idx.to_i
  expect(response_data[idx][key.to_sym]).to eql(value.to_b)
end

Then(/^the response data at "([^"]*)" should be decimal "([^"]*)"$/) do |data_path, value|
  idx, key = data_path.split('/')
  idx = idx.to_i
  expect(response_data[idx][key.to_sym]).to eql(value.to_f)
end

Then(/^the response pagination meta data should be:$/) do |string_body|
  expect({ pagination: response_pagination }.to_json).to be_json_eql(string_body)
end

Then(/^the response body should have keys:$/) do |string|
  expected = string.split(' ').map(&:to_sym)
  expect(response_body.keys).to match(expected)
end

Then(/^the response data should have keys:$/) do |string|
  expected = string.split(' ').map(&:to_sym)
  expect(response_data.keys).to match(expected)
end

Then(/^the response data should include keys:$/) do |string|
  expected = string.split(' ').map(&:to_sym)
  expect(response_data.keys).to include(*expected)
end

Then(/^the response body should include keys:$/) do |string|
  expected = string.split(' ').map(&:to_sym)
  expect(response_body.keys).to include(*expected)
end

Then(/^the response data count should be "([^"]*)"$/) do |count|
  expect(response_data).to have_exactly(count).items
end

Then(/^the response data count at "([^"]*)" should be "([^"]*)"$/) do |key, count|
  expect(response_data[key.to_sym]).to have_exactly(count).items
end

Then(/^the response data key "([^"]*)" should be "([^"]*)"$/) do |key, value|
  expect(response_data[key.to_sym]).to eq(value)
end

Then(/^the response data key "([^"]*)" should include "([^"]*)"$/) do |key, value|
  expected = value.split(' ').map(&:to_s)
  expect(response_data[key.to_sym]).to include(*expected)
end
