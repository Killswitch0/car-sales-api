# == Schema Information
#
# Table name: advertisements
#
#  id              :bigint           not null, primary key
#  brand           :string
#  model           :string
#  body_type       :string
#  mileage         :integer
#  colour          :string
#  price           :integer
#  fuel            :string
#  year            :integer
#  engine_capacity :float
#  phone_number    :string
#  name            :string
#  user_id         :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  state           :integer          default("pending")
#  likes_count     :integer          default(0)
#
FactoryBot.define do
  factory :advertisement do
    brand { Faker::Vehicle.make }
    model { Faker::Vehicle.model }
    body_type { Faker::Vehicle.car_type }
    mileage { Faker::Number.between(from: 1000, to: 100000) }
    colour { Faker::Vehicle.color }
    price { Faker::Number.between(from: 1000, to: 100000) }
    fuel { Faker::Vehicle.fuel_type }
    year { Faker::Number.between(from: 1990, to: 2022) }
    engine_capacity { Faker::Number.decimal(l_digits: 1, r_digits: 1) }
    phone_number { Faker::PhoneNumber.cell_phone }
    name { Faker::Name.name.split[0] }
    user { nil }

    transient do
      photo_file_name { 'car-photo.jpg' }
      photo_content_type { 'image/jpg' }
    end

    after(:build) do |advertisement, evaluator|
      file_path = Rails.root.join('spec', 'support', 'assets', evaluator.photo_file_name)
      advertisement.photo.attach(io: File.open(file_path), filename: evaluator.photo_file_name, content_type: evaluator.photo_content_type)
    end
  end
end
