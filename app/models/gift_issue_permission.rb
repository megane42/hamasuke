# == Schema Information
#
# Table name: gift_issue_permissions
#
#  id                  :bigint           not null, primary key
#  point               :integer          not null
#  product_name        :string(255)      not null
#  store_name          :string(255)      not null
#  survey_response_uid :string(255)      not null
#  telephone           :string(255)      not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_gift_issue_permissions_on_point                (point)
#  index_gift_issue_permissions_on_product_name         (product_name)
#  index_gift_issue_permissions_on_store_name           (store_name)
#  index_gift_issue_permissions_on_survey_response_uid  (survey_response_uid) UNIQUE
#  index_gift_issue_permissions_on_telephone            (telephone)
#
class GiftIssuePermission < ApplicationRecord
  enum product_name: { air_conditioner: "エアコン", light: "LED照明", ecocute: "エコキュート", refrigerator: "電気冷蔵庫" }
end
