ENV["RAILS_ENV"] = "test"

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)
require 'minitest/autorun'

class ActionDispatch::IntegrationTest
  setup do
    @original_logger = Railstash.logger
    @log = StringIO.new
    @logger = Logger.new(@log)
    Railstash.logger = @logger
  end

  teardown do
    Railstash.logger = @original_logger
  end

  def logged_events
    @log.string.split("\n").map(&JSON.method(:parse))
  end
end
