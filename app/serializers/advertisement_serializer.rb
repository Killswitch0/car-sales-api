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
class AdvertisementSerializer
  include JSONAPI::Serializer
  attributes :brand, :model, :body_type, :mileage, :colour, :price, :fuel, :year, :engine_capacity, :phone_number, :name, :user_id, :state

  belongs_to :user
end
