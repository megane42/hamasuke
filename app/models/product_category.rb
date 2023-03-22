# == Schema Information
#
# Table name: product_categories
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_product_categories_on_name  (name) UNIQUE
#
class ProductCategory < ApplicationRecord
  has_many :products
  enum name: { air_conditioner: "エアコン", light: "LED照明器具", ecocute: "エコキュート", refrigerator: "電気冷蔵庫" }
end
