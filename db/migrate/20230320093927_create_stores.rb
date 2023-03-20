class CreateStores < ActiveRecord::Migration[7.1]
  def change
    create_table :stores do |t|
      t.string :name, null: false, index: { unique: true }
      t.references :store_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
