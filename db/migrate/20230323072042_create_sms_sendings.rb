class CreateSmsSendings < ActiveRecord::Migration[7.1]
  def change
    create_table :sms_sendings do |t|
      t.references :gift,    null: false, index: { unique: true }, foreign_key: true
      t.datetime   :sent_at, null: false, index: { unique: false }

      t.timestamps
    end
  end
end
