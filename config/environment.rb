ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
require 'nokogiri'
require 'open-uri'

Bundler.require(:default, ENV['SINATRA_ENV'])

require_all 'app'
