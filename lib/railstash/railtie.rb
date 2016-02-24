require 'rails/railtie'

module Railstash
  class Railtie < Rails::Railtie
    initializer "railstash.instrumentation" do
      require 'logstash-event'
      Railstash.logger ||= Logger.new(Rails.root + "log/railstash_#{Rails.env}.log")

      ActiveSupport.on_load(:action_controller) do
        include Railstash::Instrumentation::ControllerRuntime
        Railstash::ControllerLogSubscriber.attach_to :action_controller
      end
    end
  end
end
