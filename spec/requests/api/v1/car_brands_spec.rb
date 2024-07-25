require 'rails_helper'

RSpec.describe "Api::V1::CarBrands", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  describe "GET /index" do
    let!(:car_brands) { create_list(:car_brand, 5) }

    scenario 'returns all brands' do
      get api_v1_car_brands_path
      expect(response).to have_http_status(200)

      response_body = JSON.parse(response.body)
      data = response_body['data']

      expect(data.count).to eq(CarBrand.count(:id))
      expect(data.count).to eq(car_brands.count)
    end
  end
end
