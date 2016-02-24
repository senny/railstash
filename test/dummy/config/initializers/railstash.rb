Railstash.configure do |c|
  c.on_log { |data| data.merge!(app_name: 'dummy_app', source: 'dummy.example.com')  }
  c.on_log { |data| data[:powered_by] = "Railstash" }
  c.on_log_action { |context, data| data['host'] = context.request.host }
end
