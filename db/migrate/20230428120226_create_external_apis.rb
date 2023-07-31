class CreateExternalApis < ActiveRecord::Migration[6.0]
  def change
    create_table :external_apis do |t|
      t.string :name
      t.string :credentials_name
      t.string :host
      t.string :test_with_endpoint

      t.timestamps
    end
  end
end
