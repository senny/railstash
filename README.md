# Railstash

Railstash writes a line based JSON logfile to feed into
[Logstash](https://www.elastic.co/products/logstash). Request processing
information is logged automatically and can be augmented further. It's also
possible to write custom log entries, either with a request context or just raw
log data.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'railstash'
```

And then execute:

    $ bundle

## Usage

Railstash can be configured using a Rails initializer:

*config/initializers/railstash.rb*
```ruby
Railstash.configure do |c|
  c.logger = Logger.new(Rails.root + 'log/railstash.log')
  c.on_log { |data| data.merge!(app_name: 'dummy_app', source: 'dummy.example.com')  }
  c.on_log_action { |context, data| data['host'] = context.request.host }
end
```

Custom events can be logged using `Railstash.log(data)` and
`Railstash.log_action(context, data)`. The later requires you to pass the
controller instance as `context`. This will augment the log with additional
request information.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/railstash.
