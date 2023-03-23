class CreateGifts < ActiveRecord::Migration[7.1]
  def change
    create_table :gifts do |t|
      t.references :gift_issue_permission, null: false, index: { unique: true }, foreign_key: true
      t.string     :url,                   null: false, index: { unique: true }
      t.integer    :initial_point,         null: false, index: { unique: false }
      t.datetime   :expired_at,            null: false, index: { unique: false }

      t.timestamps
    end
  end
end
