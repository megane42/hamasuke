# == Schema Information
#
# Table name: gift_issue_permissions
#
#  id                  :bigint           not null, primary key
#  point               :integer          not null
#  survey_response_uid :string(255)      not null
#  telephone           :string(255)      not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  product_id          :bigint           not null
#  store_id            :bigint           not null
#
# Indexes
#
#  index_gift_issue_permissions_on_point                (point)
#  index_gift_issue_permissions_on_product_id           (product_id)
#  index_gift_issue_permissions_on_store_id             (store_id)
#  index_gift_issue_permissions_on_survey_response_uid  (survey_response_uid) UNIQUE
#  index_gift_issue_permissions_on_telephone            (telephone)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (store_id => stores.id)
#
class GiftIssuePermission < ApplicationRecord
  belongs_to :product
  belongs_to :store
end
