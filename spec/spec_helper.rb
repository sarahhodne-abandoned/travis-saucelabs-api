require 'travis-saucelabs-api'
require 'rspec'
require 'webmock/rspec'

RSpec.configure do |rspec|
  rspec.expect_with(:rspec) do |config|
    config.syntax = :expect
  end
end

def a_delete(endpoint, path)
  a_request(:delete, endpoint + path)
end

def a_get(endpoint, path)
  a_request(:get, endpoint + path)
end

def a_post(endpoint, path)
  a_request(:post, endpoint + path)
end

def a_put(endpoint, path)
  a_request(:put, endpoint + path)
end

def stub_delete(endpoint, path)
  stub_request(:delete, endpoint + path)
end

def stub_get(endpoint, path)
  stub_request(:get, endpoint + path)
end

def stub_post(endpoint, path)
  stub_request(:post, endpoint + path)
end

def stub_put(endpoint, path)
  stub_request(:put, endpoint + path)
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

