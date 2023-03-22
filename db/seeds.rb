# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

["エアコン", "LED照明", "エコキュート", "電気冷蔵庫"].each do |product_category_name|
  ProductCategory.find_or_create_by!(name: product_category_name)
end

["通常店", "地域協力店"].each do |store_category_name|
  StoreCategory.find_or_create_by!(name: store_category_name)
end
