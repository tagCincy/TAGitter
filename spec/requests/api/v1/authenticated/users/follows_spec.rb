require 'rails_helper'

describe "Api::V1::Authenticated::Users::FollowsSpec", type: :request do

  describe 'as an authenticated user' do

    login

    let!(:_unfollowed_user) { create(:user) }
    let!(:_protected_user) { create(:protected_user) }
    let!(:_followed_user) { create(:user).tap { |u| u.followers << @user } }

    context 'following a user' do

      it 'should be able to follow a user' do
        post "/api/v1/authenticated/users/#{_unfollowed_user.handle}/follow", {}, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'should return the followed user' do
        post "/api/v1/authenticated/users/#{_unfollowed_user.handle}/follow", {}, @auth_headers
        expect(json[:id]).to eql(_unfollowed_user.id)
      end

      it 'should not allow following a protected user that is not a follower' do
        post "/api/v1/authenticated/users/#{_protected_user.handle}/follow", {}, @auth_headers
        expect(response).to have_http_status(:forbidden)
      end

      it 'should allow following a protected user that is already a follower' do
        @user.followers << _protected_user
        post "/api/v1/authenticated/users/#{_protected_user.handle}/follow", {}, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'should throw an error if attempting to follow an already followed user' do
        post "/api/v1/authenticated/users/#{_followed_user.handle}/follow", {}, @auth_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end

    context 'unfollowing a user' do

      it 'should unfollow the user' do
        delete "/api/v1/authenticated/users/#{_followed_user.handle}/unfollow", {}, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'should throw an error if trying to  unfollow a user not being followed' do
        delete "/api/v1/authenticated/users/#{_unfollowed_user.handle}/unfollow", {}, @auth_headers
        expect(response).to have_http_status(:not_acceptable)
      end

    end

  end

  describe 'as an unauthenticated user' do

    let!(:_user) { create :user }

    it "should not be able to follow a user" do
      post "/api/v1/authenticated/users/#{_user.handle}/follow", {}, {}
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not be able to unfollow a user" do
      delete "/api/v1/authenticated/users/#{_user.handle}/unfollow", {}, {}
      expect(response).to have_http_status(:unauthorized)
    end

  end

end