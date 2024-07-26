require 'rails_helper'

RSpec.describe "Api::V1::CarModels", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  describe "GET /index" do
    let!(:car_brand) { create(:car_brand) }
    let!(:car_models) { create_list(:car_model, 5, brand: car_brand)}

    scenario 'returns all car models' do
      get api_v1_car_models_path
      expect(response).to have_http_status(200)

      response_body = JSON.parse(response.body)
      data = response_body['data']

      expect(data.count).to eq(CarModel.count(:id))
      expect(data.count).to eq(car_models.count)
    end
  end
end
