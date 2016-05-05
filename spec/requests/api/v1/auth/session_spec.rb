require 'rails_helper'

RSpec.describe "Api::V1::Auth::Session", type: :request do

  let!(:_user) { create(:user) }

  context "with valid params" do

    it "should return a valid response" do
      post "/api/v1/auth/sign_in", {login: _user.email, password: _user.password}
      expect(response).to have_http_status(:created)
    end

    it "should allow login with handle" do
      post "/api/v1/auth/sign_in", {login: _user.handle, password: _user.password}
      expect(response).to have_http_status(:created)
    end

    it "should return the user data" do
      post "/api/v1/auth/sign_in", {login: _user.email, password: _user.password}
      expect(json[:id]).to eql(_user[:id])
    end

    it "should return necessary auth headers" do
      post "/api/v1/auth/sign_in", {login: _user.email, password: _user.password}
      expect(response.headers).to include("access-token")
    end

  end

  context "with invalid params" do

    it "should return an invalid response" do
      post "/api/v1/auth/sign_in", {login: _user.email, password: "foobar"}
      expect(response).to have_http_status(:unauthorized)
    end

    it "should return the errors" do
      post "/api/v1/auth/sign_in", {login: _user.email, password: "foobar"}
      expect(json[:errors]).to_not be_nil
    end

  end

end