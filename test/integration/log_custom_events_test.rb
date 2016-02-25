require 'test_helper'

class LogCustomEventsTest < ActionDispatch::IntegrationTest
  test "log custom events (with context)" do
    travel_to Time.parse("2016-01-09T10:52:00.000Z") do
      get '/custom_with_context', {status: 'closed'}, { "User-Agent" => "Googlebot/2.1 (+http://www.google.com/bot.html)", "Referer" => "http://example.com/articles"}
    end

    data = logged_events.first
    variable_data = data.extract!("request_id")

    assert_equal({ "message"=>"omg request!",
                   "level"=>"warning",
                   "method"=>"GET",
                   "path"=>"/custom_with_context",
                   "fullpath"=>"/custom_with_context?status=closed",
                   "controller"=>"custom_log",
                   "action"=>"with_context",
                   "route"=>"custom_log#with_context",
                   "format"=>"html",
                   "ip"=>"127.0.0.1",
                   "user_agent"=>"Googlebot/2.1 (+http://www.google.com/bot.html)",
                   "referer"=>"http://example.com/articles",
                   "parameters"=>{"status"=>"closed"},
                   "app_name"=>"dummy_app",
                   "source"=>"dummy.example.com",
                   "tags"=>["log"],
                   "host"=>"www.example.com",
                   "powered_by"=>"Railstash",
                   "@timestamp"=>"2016-01-09T10:52:00.000Z",
                   "@version"=>"1"}, data)
  end

  test "log custom events (without context)" do
    travel_to Time.parse("2016-01-16T17:29:34.000Z") do
      get '/custom_without_context'
    end

    data = logged_events.first
    assert_equal({ "message"=>"zomg!",
                   "parameters"=>{"order_id"=>1},
                   "app_name"=>"dummy_app",
                   "source"=>"dummy.example.com",
                   "tags"=>["log"],
                   "powered_by"=>"Railstash",
                   "@timestamp"=>"2016-01-16T17:29:34.000Z",
                   "@version"=>"1"}, data)
  end
end
