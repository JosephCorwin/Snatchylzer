class CreateExternalDataEndpoints < ActiveRecord::Migration[6.0]
  def change
    create_table :external_data_endpoints do |t|
      t.references :external_api
      t.string :name
      t.text :credentials_map
      t.string :path
      t.text :required_params
      t.string :response_key
      t.text :column_mapping
      t.text :error_map

      t.timestamps
    end
  end
end
