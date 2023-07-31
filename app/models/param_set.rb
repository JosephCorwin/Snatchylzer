class ParamSet < ApplicationRecord
  belongs_to :external_data_endpoint, optional: true
  has_many :api_job_profiles

  serialize :body
  serialize :looper
end
