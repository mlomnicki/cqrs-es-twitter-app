ENV["RAILS_ENV"] ||= "test"
$VERBOSE = false
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require_relative "lib/command_handlers/test_case"
