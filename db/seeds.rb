# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create(email: 'user@mail.com', password: '111111', name: 'Alex', admin: true)

15.times do 
  a = Advertisement.create(
    brand: Faker::Vehicle.make, 
    model: Faker::Vehicle.model, 
    body_type: Faker::Vehicle.car_type, 
    mileage: Faker::Number.between(from: 1000, to: 100000), 
    colour: Faker::Vehicle.color, 
    price: Faker::Number.between(from: 1000, to: 100000), 
    fuel: Faker::Vehicle.fuel_type, 
    year: Faker::Number.between(from: 1990, to: 2022), 
    engine_capacity: Faker::Number.decimal(l_digits: 1, r_digits: 1), 
    phone_number: Faker::PhoneNumber.cell_phone, 
    name: Faker::Name.name.split[0], 
    user: user
  )

  a.photo.attach(
    io: File.open('spec/support/assets/car-photo.jpg'),
    filename: 'car-photo.jpg',
    content_type: 'image/jpg'
  )
end