require 'rails_helper'

describe 'Api::V1::Authenticated::Posts::Repost', type: :request do

  describe 'as an authenticated user' do

    login

    context 'POST /reposts' do

      let!(:_post) { create(:post) }
      let!(:_protected_post) { create(:protected_post) }

      it 'should return a valid response' do
        post "/api/v1/authenticated/posts/#{_post.id}/repost", {}, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it "should create a new repost post" do
        expect {
          post "/api/v1/authenticated/posts/#{_post.id}/repost", {}, @auth_headers
        }.to change(Post, :count).by(1)

        expect(_post.reload.repost_ids).to include(json[:id])
      end

      it 'should return the repost' do
        post "/api/v1/authenticated/posts/#{_post.id}/repost", {}, @auth_headers
        expect(json[:repost][:id]).to eql(_post.id)
      end

      it "should not allow a user to repost a protected post" do
        post "/api/v1/authenticated/posts/#{_protected_post.id}/repost", {}, @auth_headers
        expect(response).to have_http_status(:forbidden)
      end

      it "should allow reposting a protected post from a following user" do
        _protected_post.user.followers << @user
        post "/api/v1/authenticated/posts/#{_post.id}/repost", {}, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'should not allow a user to repost their own post' do
        own_post = create(:post, user: @user)
        post "/api/v1/authenticated/posts/#{own_post.id}/repost", {}, @auth_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'should not allow a user to repost the same post multiple times' do
        _post.reposts << create(:post, user: @user)
        post "/api/v1/authenticated/posts/#{_post.id}/repost", {}, @auth_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end

    end

  end

  describe 'as an unauthenticated user' do
      it 'should not allow unauthorized access' do
        post "/api/v1/authenticated/posts/1/repost"
        expect(response).to have_http_status(:unauthorized)
      end
  end

end