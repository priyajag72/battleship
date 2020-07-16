require "./lib/battleship"
require 'bundler/inline'

gemfile true do
 source 'http://rubygems.org'
 gem 'colorize'
end

battleship = Battleship.new
