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
