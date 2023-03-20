class Product < ApplicationRecord
  enum name: { air_conditioner: "エアコン", light: "LED照明", ecocute: "エコキュート", refrigerator: "電気冷蔵庫" }
end
