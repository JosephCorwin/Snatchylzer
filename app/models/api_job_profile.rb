class ApiJobProfile < ApplicationRecord
  belongs_to :param_set

  validates :name, presence: true, uniqueness: { case_sensitive: true }
  validates :service_name, presence: true
end
