# == Schema Information
#
# Table name: products
#
#  id                  :bigint           not null, primary key
#  name                :string(255)      not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  product_category_id :bigint           not null
#
# Indexes
#
#  index_products_on_name                 (name) UNIQUE
#  index_products_on_product_category_id  (product_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_category_id => product_categories.id)
#
class Product < ApplicationRecord
  belongs_to :store_category
end
