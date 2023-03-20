# == Schema Information
#
# Table name: stores
#
#  id                :bigint           not null, primary key
#  name              :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  store_category_id :bigint           not null
#
# Indexes
#
#  index_stores_on_name               (name) UNIQUE
#  index_stores_on_store_category_id  (store_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_category_id => store_categories.id)
#
class Store < ApplicationRecord
  has_many   :gift_issue_permissions
  belongs_to :store_category
end
