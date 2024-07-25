# == Schema Information
#
# Table name: car_brands
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CarBrand < ApplicationRecord
  has_many :models, foreign_key: :car_brand_id, class_name: 'CarModel'
end
