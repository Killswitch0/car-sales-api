class AdvertisementSerializer
  include JSONAPI::Serializer
  attributes :brand, :model, :body_type, :mileage, :colour, :price, :fuel, :year, :engine_capacity, :phone_number, :name, :user_id, :state
end
