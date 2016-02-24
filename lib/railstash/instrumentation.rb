module Railstash
  module Instrumentation
    def self.extract_context_data(context)
      request = context.request
      params = request.parameters
      data = {}
      data[:method] = request.request_method
      data[:path] = request.path
      data[:fullpath] = request.fullpath
      data[:controller] = params["controller"]
      data[:action] = params["action"]
      data[:route] = "#{params["controller"]}##{params["action"]}"
      data[:format] = request.format.ref
      data[:ip] = request.remote_ip
      data[:user_agent] = request.user_agent
      data[:referer] = request.referer
      data[:parameters] = request.filtered_parameters.except("utf8","authenticity_token",
                                                             *ActionController::LogSubscriber::INTERNAL_PARAMS)
      if request.respond_to? :request_id
        data[:request_id] = request.request_id
      else
        data[:request_id] = request.uuid
      end
      data
    end

    module ControllerRuntime
      def append_info_to_payload(payload)
        super
        data = Railstash::Instrumentation.extract_context_data(self)
        Railstash.run_callbacks :on_log_action_callbacks, self, data

        payload[:railstash] = data
      end
    end
  end
end
