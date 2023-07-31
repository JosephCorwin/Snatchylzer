module ETL
  module Connect
    # renames keys from API responses
    class ColumnMapper < ApplicationService
      attr_reader :map, :results

      def initialize(endpoint, results)
        @map = endpoint.column_mapping
        @results = results
      end

      def call
        results.each do |chit|
          map[:rekey].each_pair do |key, value|
            chit[value] = chit.delete(key)
          end
          map[:destroy].each do |key|
            chit.delete(key)
          end
        end
        results
      rescue
        results
      end
    end
  end
end
