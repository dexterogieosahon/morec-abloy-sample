# frozen_string_literal: true

# Concat base_path and path
# @param [String] path request path
# @return [String] uri
def uri(path)
  "#{@base_path}#{path}"
end

Given(/^I send and accept plain text$/) do
  header('Content-Type', 'text/plain')
  header('Accept', 'text/plain')
end

Given(/^I send and accept JSON$/) do
  header('Content-Type', 'application/json;charset=utf-8')
  header('Accept', 'application/json;charset=utf-8')
end

Given(/^The API base path is "([^"]*)"$/) do |base_path|
  @base_path = base_path
end

When(/^I send a GET request to "([^"]*)"$/) do |path|
  get uri(path)
end

When(/^I send a POST request to "([^\"]*)" with the following:$/) do |path, payload|
  post(uri(path), payload)
end

When(/^I send a PATCH request to "([^"]*)" with the following:$/) do |path, payload|
  patch(uri(path), payload)
end

When(/^I send a PUT request to "([^\"]*)" with the following:$/) do |path, payload|
  put(uri(path), payload)
end

When(/^I send a DELETE request to "([^"]*)"$/) do |path|
  delete uri(path)
end

When(/^I send a GET request to the resource "([^"]*)"$/) do |resource_path|
  get uri(Mustache.render(resource_path, id: @last_resource.sid))
end

When(/^I send a PATCH request to the resource "([^"]*)" with the following:$/) do |resource_path, payload|
  patch(uri(Mustache.render(resource_path, id: @last_resource.sid)), payload)
end

When(/^I send a PUT request to the resource "([^"]*)" with the following:$/) do |resource_path, payload|
  put(uri(Mustache.render(resource_path, id: @last_resource.sid)), payload)
end

When(/^I send a DELETE request to the resource "([^"]*)"$/) do |resource_path|
  delete uri(Mustache.render(resource_path, id: @last_resource.sid))
end

