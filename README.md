# Railstash


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'railstash'
```

And then execute:

    $ bundle

## Usage

*config/initializers/railstash.rb*

```
Railstash.configure do |c|
  c.on_log { |data| data.merge!(app_name: 'dummy_app', source: 'dummy.example.com')  }
  c.on_log_action { |context, data| data['host'] = context.request.host }
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/railstash.
