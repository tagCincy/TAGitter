require 'rails_helper'

RSpec.describe "Api::V1::Auth::Registration", type: :request do

  context "with valid params" do

    let(:_user_params) { attributes_for(:user) }

    it "should return a valid response" do
      post '/api/v1/auth', _user_params
      expect(response).to have_http_status(:created)
    end

    it "should create a new user" do
      expect {
        post '/api/v1/auth', _user_params
      }.to change(User, :count).by(1)
    end

    it "should set the profile name to the handle if not supplied" do
      unnamed_user = attributes_for(:user)
      post '/api/v1/auth', unnamed_user
      expect(User.last.name).to eql(unnamed_user[:handle])
    end

    it "should return the created user" do
      post '/api/v1/auth', _user_params
      expect(json[:email]).to eql(_user_params[:email])
    end

    it "should return necessary auth headers" do
      post '/api/v1/auth', _user_params
      expect(response.headers).to include("access-token")
    end

  end

  context "with invalid params" do

    let!(:_invalid_user_params) { attributes_for(:user, email: nil) }

    it "should return an invalid response" do
      post '/api/v1/auth', _invalid_user_params
      expect(response).to have_http_status(:forbidden)
    end

    it "should not create a user" do
      expect {
        post '/api/v1/auth', _invalid_user_params
      }.to_not change(User, :count)
    end

    it "should return the errors" do
      post '/api/v1/auth', _invalid_user_params
      expect(json[:errors]).to_not be_nil
    end

  end

end