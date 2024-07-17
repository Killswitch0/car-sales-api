require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  let(:user) { create(:user) }
  
  describe "POST /signup" do
    scenario "user sign up successfuly" do
      post user_registration_path, params: { user: { email: user.email, password: user.password, name: user.name } } 
      expect(response).to have_http_status(200)
    end
  end
end