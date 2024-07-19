require 'rails_helper'

RSpec.describe "Api::V1::Advertisements", type: :request do
  let!(:user) { create(:user) }

  before do 
    sign_in(user)
  end

  describe "GET /api/v1/advertisements" do
    let!(:advertisements) { create_list(:advertisement, 5, user: user) }
    scenario 'user gets specific collection' do
      get api_v1_advertisements_path
      response_body = JSON.parse(response.body)
      expect(response_body['data'].length).to eq(5)
    end
  end

  describe "GET /api/v1/advertisements/:id" do
    let(:advertisement) { create(:advertisement, user: user) }

    scenario 'user gets specific object' do
      get api_v1_advertisement_path(advertisement)
      expect(response).to have_http_status(200)

      response_id = JSON.parse(response.body)['data']['id'].to_i
      expect(response_id).to eq(advertisement.id)
    end
  end

  describe "POST /api/v1/advertisements" do
    context 'with valid parameters' do
      scenario 'creates a new advertisement' do
        valid_params = attributes_for(:advertisement, user: user)

        post api_v1_advertisements_path, params: { advertisement: valid_params }
        expect(response).to have_http_status(201)
        
        response_id = JSON.parse(response.body)['data']['id'].to_i
        expect(response_id).to eq(Advertisement.last.id)
      end
    end

    context "with invalid parameters" do
      scenario 'does not create a new advertisement' do
        invalid_params = { brand: nil, user: user } 

        post api_v1_advertisements_path, params: { advertisement: invalid_params }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PATCH /api/v1/advertisements/:id" do
    let(:advertisement) { create(:advertisement, user: user) }
    scenario 'updates an existing advertisement' do
      new_attributes = { brand: 'Updated Brand' }

      patch api_v1_advertisement_path(advertisement), params: { advertisement: new_attributes }

      expect(response).to have_http_status(200)
      
      response_brand = JSON.parse(response.body)['data']['attributes']['brand']
      expect(response_brand).to eq(new_attributes[:brand])
    end
  end

  describe "DELETE /api/v1/advertisements/:id" do
    let(:advertisement) { create(:advertisement, user: user) }
    scenario 'deletes an existing advertisement' do
      delete api_v1_advertisement_path(advertisement)

      expect(response).to have_http_status(204)
      expect { Advertisement.find(advertisement.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "DELETE /api/v1/advertisements/:id/destroy_photo" do
    let(:advertisement) { create(:advertisement, user: user) }

    scenario 'user successfully delete advertisement photo' do
      delete destroy_photo_api_v1_advertisement_path(advertisement)
      advertisement.reload

      expect(response).to have_http_status(200)
      expect(advertisement.photo.attached?).to eq(false)
    end
  end

  describe "GET /api/v1/advertisements/by_state" do
    let!(:advertisement_active) { create(:advertisement, user: user) }
    let!(:advertisement_pending) { create(:advertisement, user: user, state: 'rejected') }
    scenario 'returns advertisements filtered by state' do
      get by_state_api_v1_advertisements_path, params: { state: 'pending' }

      expect(response).to have_http_status(200)

      response_data = JSON.parse(response.body)['data']
      
      expect(response_data.length).to eq(1)
      expect(response_data[0]['attributes']['state']).to eq('pending')
    end

    scenario 'returns all advertisements when no state is provided' do
      get '/api/v1/advertisements/by_state'

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['data'].length).to eq(2)
    end
  end

  describe "POST /api/v1/advertisements/:id/like" do
    let(:advertisement) { create(:advertisement, user: user) }

    scenario 'creates a like for the advertisement' do
      post like_api_v1_advertisement_path(advertisement)

      expect(response).to have_http_status(204)
      expect(user.likes.exists?(likeable: advertisement)).to eq(true)
    end
  end

  describe "DELETE /api/v1/advertisements/:id/unlike" do
    let(:advertisement) { create(:advertisement, user: user) }
    let!(:like) { create(:like, user: user, likeable: advertisement) }

    scenario 'removes the like for the advertisement' do
      delete unlike_api_v1_advertisement_path(advertisement)

      expect(response).to have_http_status(204)
      expect(user.likes.exists?(likeable: advertisement)).to eq(false)
    end
  end
end
