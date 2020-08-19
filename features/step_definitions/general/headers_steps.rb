# frozen_string_literal: true

Given(/^I set header "([^"]*)" with value "([^"]*)"$/) do |key, value|
  header(key, value)
end

Given(/^I unset header "([^"]*)"$/) do |key|
  header(key, nil)
end
