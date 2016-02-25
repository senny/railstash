require 'active_support/log_subscriber'

module Railstash
  class ControllerLogSubscriber < ::ActiveSupport::LogSubscriber
    def process_action(event)
      payload = event.payload
      data = {
        tags: ['request'],
        status: payload[:status]
      }
      data.merge!(payload[:railstash])
      data.merge!(runtimes(event))

      Railstash.log(data)
    end

    private
    def runtimes(event)
      {
        duration: event.duration,
        view: event.payload[:view_runtime],
        db: event.payload[:db_runtime]
      }.map { |key, value|
        [key, value.to_f.round(2)] if value
      }.compact.to_h
    end
  end
end
