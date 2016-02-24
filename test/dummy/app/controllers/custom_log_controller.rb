class CustomLogController < ApplicationController
  def with_context
    render nothing: true

    Railstash.log_action(self, message: 'omg request!', level: "warning")
  end

  def without_context
    Railstash.log(message: 'zomg!', parameters: {order_id: 1})
    render nothing: true
  end
end
