class CallService < ApplicationJob
  queue_as :default

  def perform(service_name, params)
    retry_count = 3
    begin
      ApplicationService.const_get(service_name).call params
    rescue ActiveRecord::ConnectionTimeoutError => e
      retry_count -= 1
      retry unless retry_count < 1
      Rails.logger.info { e.message.to_s }
    end
  end
end
