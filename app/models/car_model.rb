# == Schema Information
#
# Table name: car_models
#
#  id           :bigint           not null, primary key
#  name         :string
#  car_brand_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class CarModel < ApplicationRecord
  belongs_to :brand, foreign_key: :car_brand_id, class_name: 'CarBrand'
end
