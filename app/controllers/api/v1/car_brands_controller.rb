class Api::V1::CarBrandsController < ApplicationController
  def index
    @car_brands = CarBrand.all
    render json: CarBrandSerializer.new(@car_brands).serializable_hash.to_json
  end
end
