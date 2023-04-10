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
  encrypts :telephone, deterministic: true

  enum product_category_name: { air_conditioner: "エアコン", light: "LED照明器具", ecocute: "エコキュート", refrigerator: "電気冷蔵庫" }

  has_one :gift
  has_one :sms_sending, through: :gift

  scope :gift_issued,   -> { where.associated :gift }
  scope :gift_unissued, -> { where.missing    :gift }
  scope :sms_sent,      -> { where.associated :sms_sending }
  scope :sms_unsent,    -> { where.missing    :sms_sending }
  scope :completed,     -> { sms_sent }
  scope :uncompleted,   -> { sms_unsent }

  delegate :created_at, to: :gift, prefix: true, allow_nil: true
  delegate :url,        to: :gift, prefix: true, allow_nil: true
  delegate :send_sms!,  to: :gift
  delegate :sent_at,    to: :sms_sending, prefix: true, allow_nil: true

  def self.ransackable_attributes(auth_object = nil)
    ["survey_response_uid", "telephone"]
  end

  def self.ransackable_scopes(auth_object = nil)
    ["ransack_gift_issued", "ransack_sms_sent"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["gift", "sms_sending"]
  end

  scope :ransack_gift_issued, -> (keyword) {
    case keyword
    when "gift_issued"
      gift_issued
    when "gift_unissued"
      gift_unissued
    else
      all
    end
  }

  scope :ransack_sms_sent, -> (keyword) {
    case keyword
    when "sms_sent"
      sms_sent
    when "sms_unsent"
      sms_unsent
    else
      all
    end
  }

  def self.import_csv(csv_file)
    return if csv_file.nil?
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

  def issue_gift!
    Gift.issue!(gift_issue_permission: self)
  end
end
