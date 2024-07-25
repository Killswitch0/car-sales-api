# == Schema Information
#
# Table name: car_brands
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CarBrandSerializer
  include JSONAPI::Serializer
  attributes :name

  has_many :models, serializer: 'CarBrand'
end
