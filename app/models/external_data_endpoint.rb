class ExternalDataEndpoint < ApplicationRecord
  belongs_to :api, class_name: 'ExternalApi', foreign_key: :external_api_id
  has_many :param_sets

  serialize :response_key
  serialize :column_mapping
  serialize :required_params
  serialize :error_map
  serialize :credentials_map

  before_create :init_maps

  # syntactic sugar
  def full_url
    "#{api.host}#{path}"
  end

  # helps guard against leakage of credentials
  def get(params)
    credentialize(:attach, params)
    results = ETL::Connect::Operator.call(self, params)
    credentialize(:strip, params)
    results
  end

  def supports_pagination?
    response_key[:page_param].present? &&
      response_key[:page_total].present? &&
      response_key[:grand_total].present?
  end

  private

  def credentialize(mode, params)
    case mode
    when :attach
      params.merge!(api.credentials)
    when :strip
      api.credentials.each_key do |k|
        params.delete(k)
      end
    end
  end

  def init_maps
    self.response_key ||= {}
    self.error_map ||= {}
    self.column_mapping ||= {}
    self.required_params ||= []
  end
end
