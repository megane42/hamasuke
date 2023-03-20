class CreateStoreCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :store_categories do |t|
      t.string :name, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
