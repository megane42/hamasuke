# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_products_on_name  (name) UNIQUE
#
class Product < ApplicationRecord
  has_many :gift_issue_permissions
  enum name: { air_conditioner: "エアコン", light: "LED照明", ecocute: "エコキュート", refrigerator: "電気冷蔵庫" }
end
