require "railstash/version"
require "railstash/instrumentation"
require "railstash/subscribers"
require "railstash/railtie"

module Railstash
  mattr_accessor :logger, instance_accessor: false
  mattr_accessor(:on_log_callbacks, instance_accessor: false) { [] }
  mattr_accessor(:on_log_action_callbacks, instance_accessor: false) { [] }

  def self.configure
    yield self
  end

  def self.on_log(&block)
    self.on_log_callbacks << block
  end

  def self.on_log_action(&block)
    self.on_log_action_callbacks << block
  end

  def self.log_action(context, data)
    run_callbacks :on_log_action_callbacks, context, data
    log(data.merge(Railstash::Instrumentation.extract_context_data(context)))
  end

  def self.log(data)
    data[:tags] ||= ["log"]
    run_callbacks :on_log_callbacks, data

    _log(data)
  end

  def self._log(data)
    logstash_event = ::LogStash::Event.new(data)
    Railstash.logger << logstash_event.to_json + "\n"
  end

  def self.run_callbacks(chain, *args)
    send(chain).each { |callback| callback.call(*args) }
  end
end
