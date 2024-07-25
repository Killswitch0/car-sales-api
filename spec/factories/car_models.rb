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
FactoryBot.define do
  factory :car_model do
    name { Faker::Vehicle.model }
  end
end
