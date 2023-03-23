# == Schema Information
#
# Table name: gift_issue_permissions
#
#  id                    :bigint           not null, primary key
#  point                 :integer          not null
#  product_category_name :string(255)      not null
#  store_name            :string(255)      not null
#  survey_response_uid   :string(255)      not null
#  telephone             :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_gift_issue_permissions_on_point                  (point)
#  index_gift_issue_permissions_on_product_category_name  (product_category_name)
#  index_gift_issue_permissions_on_store_name             (store_name)
#  index_gift_issue_permissions_on_survey_response_uid    (survey_response_uid) UNIQUE
#  index_gift_issue_permissions_on_telephone              (telephone)
#
require "csv"

class GiftIssuePermission < ApplicationRecord
  enum product_category_name: { air_conditioner: "エアコン", light: "LED照明器具", ecocute: "エコキュート", refrigerator: "電気冷蔵庫" }

  has_one :gift
  has_one :sms_sending

  scope :unissued, -> { where.missing(:gift) }
  scope :unsent,   -> { where.missing(:sms_sending) }

  delegate :url, to: :gift, prefix: true

  def self.import_csv(csv_file)
    attributes = CSV.foreach(csv_file.path, headers: true, encoding: "SJIS:UTF-8").map do |row|
      {
        point:                 row["金額"],
        product_category_name: row["商品グループ"],
        store_name:            row["購入店舗"],
        survey_response_uid:   row["public_uid"],
        telephone:             row["携帯電話番号"],
      }
    end
    insert_all(attributes)
  end

  def product_category_name
    self.class.product_category_names[super]
  end

  def issue_gift
    if gift.blank?
      build_gift.issue
    else
      gift
    end
  end

  def send_sms
    if sms_sending.blank?
      build_sms_sending.send_sms
    else
      sms_sending
    end
  end
end
