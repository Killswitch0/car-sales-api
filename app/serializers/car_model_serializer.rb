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
class CarModelSerializer
  include JSONAPI::Serializer
  attributes :name

  belongs_to :car_brand
end
