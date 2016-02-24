require 'test_helper'

class LogRequestsTest < ActionDispatch::IntegrationTest
  test "log application requests for logstash" do
    travel_to "2016-02-24T10:44:01" do
      get '/articles', {page: 1, batch: 50}, { "User-Agent" => "Googlebot/2.1 (+http://www.google.com/bot.html)", "Referer" => "http://example.com/"}
    end

    data = logged_events.first
    variable_data = data.extract!("request_id", "duration", "view", "db")
    assert_equal({ "method"=>"GET",
                   "path"=>"/articles",
                   "fullpath"=>"/articles?page=1&batch=50",
                   "route"=>"articles#index",
                   "format"=>"html",
                   "controller"=>"articles",
                   "action"=>"index",
                   "status"=>200,
                   "ip"=>"127.0.0.1",
                   "user_agent"=> "Googlebot/2.1 (+http://www.google.com/bot.html)",
                   "referer"=>"http://example.com/",
                   "parameters"=>{"page"=>"1", "batch"=>"50"},
                   "app_name"=>"dummy_app",
                   "source"=>"dummy.example.com",
                   "tags"=>["request"],
                   "host"=>"www.example.com",
                   "powered_by"=>"Railstash",
                   "@timestamp"=>"2016-02-24T09:44:01.000Z",
                   "@version"=>"1"}, data)

    assert_match(/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}/, variable_data["request_id"])
    assert_instance_of(Float, variable_data["view"])
    assert_match(/[0-9.]+/, variable_data["view"].to_s)
  end
end
