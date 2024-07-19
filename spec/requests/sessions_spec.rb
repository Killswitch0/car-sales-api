require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }

  describe "POST /login" do
    scenario "user sign in successfully" do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      expect(response).to have_http_status(200)
      
      json_response = JSON.parse(response.body)
      user_data = json_response['status']['data']['user']

      expect(user_data['email']).to eq(user.email)
      expect(user_data['name']).to eq(user.name)
    end
  end

  describe "DELETE /logout" do
    scenario "user logout sucessfully" do 
      log_in(user)

      headers = { "Authorization": response.headers["Authorization"] }

      delete destroy_user_session_path, headers: headers
      expect(response).to have_http_status(200)
      
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq('Logged out successfully.')
    end
  end
end
