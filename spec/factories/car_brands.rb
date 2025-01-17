# == Schema Information
#
# Table name: car_brands
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :car_brand do
    name { Faker::Vehicle.manufacture }
  end
end
