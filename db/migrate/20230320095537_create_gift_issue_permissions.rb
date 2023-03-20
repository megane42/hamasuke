class CreateGiftIssuePermissions < ActiveRecord::Migration[7.1]
  def change
    create_table :gift_issue_permissions do |t|
      t.string     :survey_response_uid, null: false, index: { unique: true }
      t.string     :telephone,           null: false, index: { unique: false }
      t.integer    :point,               null: false, index: { unique: false }
      t.references :product,             null: false, foreign_key: true
      t.references :store,               null: false, foreign_key: true

      t.timestamps
    end
  end
end
