module ETL
  module Connect
    # sends GET request to API host server
    class Operator < ApplicationService
      attr_reader :endpoint, :params

      def initialize(endpoint, params)
        @endpoint = endpoint
        @params = params

        raise MissingRequiredParams unless required_params_present?(params)
      end

      def call
        results = Requester.call(endpoint, params)
        return false if auth_failed?(results)

        endpoint.response_key.present? ? results = PageCollector.call(endpoint, params, results) : nil
        ColumnMapper.call(endpoint, results)
      end

      class MissingRequiredParams < StandardError; end

      private

      def required_params_present?(params)
        return true unless endpoint.required_params.present?

        endpoint.required_params.each do |p|
          break false unless params.include?(p)
        end
      end

      def auth_failed?(results)
        return false unless endpoint.error_map.present?
        return false unless endpoint.error_map[:auth_fail_key]
        return false unless results[0][endpoint.error_map[:auth_fail_key]]
      end
    end
  end
end
