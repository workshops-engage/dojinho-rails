# encoding: UTF-8

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
end

require 'machinist/active_record'

Movie.blueprint do
  imdb_id { rand(100_000) }
  url { "http://imdb.com/#{imdb_id}" }
  title { Faker::Name.name }
end

Favorite.blueprint do
  user
  movie
  rank { (1..10).to_a.sample }
end

User.blueprint do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  password { '123456' }
end