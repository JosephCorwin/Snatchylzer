class BatchJob < ApplicationJob
  queue_as :default

  def perform(where_clause)
    ApiJobProfile.where(where_clause).each do |job_profile|
      ApiJob.peform_later(job_profile)
    end
  end
end
