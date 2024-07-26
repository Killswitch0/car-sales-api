class Api::V1::CarModelsController < ApplicationController
  def index
    @car_models = CarModel.all
    render json: CarModelSerializer.new(@car_models).serializable_hash.to_json
  end
end
