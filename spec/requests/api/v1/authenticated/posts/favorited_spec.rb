require 'rails_helper'

describe "Api::V1::Authenticated::Posts::FavoritedSpec", type: :request do

  describe 'as an authenticated user' do

    login

    let!(:_unfavorited_post) { create(:post) }
    let!(:_protected_post) { create(:protected_post) }
    let!(:_favorited_post) { create(:post).tap { |p| p.users_favorited << @user } }

    context 'favoriting a post' do

      it 'should be able to favorite a post' do
        post "/api/v1/authenticated/posts/#{_unfavorited_post.id}/favorite", {}, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'should return the favorited post' do
        post "/api/v1/authenticated/posts/#{_unfavorited_post.id}/favorite", {}, @auth_headers
        expect(json[:id]).to eql(_unfavorited_post.id)
      end

      it 'should not allow favoriting a protected post from a unfollowed user' do
        post "/api/v1/authenticated/posts/#{_protected_post.id}/favorite", {}, @auth_headers
        expect(response).to have_http_status(:forbidden)
      end

      it 'should allow favoriting a protected post from a followed user' do
        @user.followed << _protected_post.user
        post "/api/v1/authenticated/posts/#{_protected_post.id}/favorite", {}, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'should throw an error if attempting to favorite an already favorited post' do
        post "/api/v1/authenticated/posts/#{_favorited_post.id}/favorite", {}, @auth_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end

    context 'unfavoriting a post' do

      it 'should unfavorite the post' do
        delete "/api/v1/authenticated/posts/#{_favorited_post.id}/unfavorite", {}, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'should throw an error if trying to  unfavorite a post not favorited' do
        delete "/api/v1/authenticated/posts/#{_unfavorited_post.id}/unfavorite", {}, @auth_headers
        expect(response).to have_http_status(:not_acceptable)
      end

    end

  end

  describe 'as an unauthenticated user' do

    let!(:_post) { create :post }

    it "should not be able to favorite a post" do
      post "/api/v1/authenticated/posts/#{_post.id}/favorite", {}, {}
      expect(response).to have_http_status(:unauthorized)
    end

    it "should not be able to unfavorite a post" do
      delete "/api/v1/authenticated/posts/#{_post.id}/unfavorite", {}, {}
      expect(response).to have_http_status(:unauthorized)
    end

  end

end