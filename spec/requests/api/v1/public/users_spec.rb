require 'rails_helper'

RSpec.describe "Api::V1::Public::Users", type: :request do

  describe 'GET /users/:id' do

    let!(:_user) { create(:user) }

    it 'should return a valid response' do
      get "/api/v1/public/users/#{_user.handle}"
      expect(response).to have_http_status(:success)
    end

    it "should accept user_id in route" do
      get "/api/v1/public/users/#{_user.id}"
      expect(response).to have_http_status(:success)
    end

    it 'should return the desired user' do
      get "/api/v1/public/users/#{_user.handle}"
      expect(json[:id]).to eql(_user.id)
    end

    it 'should not return a protected user' do
      protected_user = create(:protected_user)
      get "/api/v1/public/users/#{protected_user.handle}"
      expect(response).to have_http_status(:not_found)
    end

  end

end