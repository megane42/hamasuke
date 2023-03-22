class CreateGiftIssuePermissions < ActiveRecord::Migration[7.1]
  def change
    create_table :gift_issue_permissions do |t|
      t.string  :survey_response_uid,   null: false, index: { unique: true }
      t.string  :telephone,             null: false, index: { unique: false }
      t.integer :point,                 null: false, index: { unique: false }
      t.string  :product_category_name, null: false, index: { unique: false }
      t.string  :store_name,            null: false, index: { unique: false }

      t.timestamps
    end
  end
end
