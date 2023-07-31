module ETL
  module Connect
    # collects all data for a given set of params
    # iterates over pages of data if endpoint supports pagination
    # currently only supports 0-index pagination schemes
    class PageCollector < ApplicationService
      attr_reader :endpoint, :params, :response
      attr_accessor :page, :key

      def initialize(endpoint, params, response)
        @endpoint = endpoint
        @key = endpoint.response_key
        @params = params
        @response = response
        @page = nil
      end

      def call
        return response unless endpoint.head?

        results = response[key[:results]]
        return results unless endpoint.supports_pagination? && page_total(response) > 1

        results += @page while next_page
        results
      end

      private

      def next_page
        params[key[:page_param]] = params[key[:page_param]].to_i + 1
        @page = Requester.call(endpoint, params)[key[:results]]
        @page.present?
      end

      def page_total(response)
        return 0 if response[key[:grand_total]].nil? || response[key[:page_total]].nil?

        (response[key[:grand_total]].to_f / response[key[:page_total]])
      end
    end
  end
end
