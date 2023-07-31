class CreateParamSets < ActiveRecord::Migration[6.0]
  def change
    create_table :param_sets do |t|
      t.references :external_data_endpoint, null: false, foreign_key: true
      t.string :name
      t.text :body
      t.text :looper

      t.timestamps
    end
  end
end
