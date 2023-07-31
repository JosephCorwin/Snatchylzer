class ExternalApi < ApplicationRecord
  has_many :endpoints, class_name: 'ExternalDataEndpoint'

  serialize :test_with

  def credentials
    Rails.application.credentials.send(credentials_name.to_sym)
  end
end
