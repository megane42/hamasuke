# == Schema Information
#
# Table name: store_categories
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_store_categories_on_name  (name) UNIQUE
#
class StoreCategory < ApplicationRecord
  enum name: { general: "通常店", local: "地域協力店" }
end
