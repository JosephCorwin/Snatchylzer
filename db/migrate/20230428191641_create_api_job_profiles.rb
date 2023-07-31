class CreateApiJobProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :api_job_profiles do |t|
      t.references :param_set, null: false, foreign_key: true
      t.string :name
      t.string :service_name
      t.string :job_set

      t.timestamps
    end
  end
end
