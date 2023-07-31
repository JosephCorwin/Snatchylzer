module ETL
  module Connect
    # sends GET request to API host server
    class Requester < ApplicationService
      attr_reader :endpoint, :params

      def initialize(endpoint, params)
        @endpoint = endpoint
        @params = params
      end

      def call
        JSON.parse(HTTP.get(endpoint.full_url, params: params), symbolize_names: true)
      end
    end
  end
end
