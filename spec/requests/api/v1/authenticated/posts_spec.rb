require 'rails_helper'

describe 'Api::V1::Authenticated::PostsSpec', type: :request do

  describe 'as an authenticated user' do

    login

    context 'GET /posts' do

      let!(:_posts) do
        users = create_list(:user, 3).tap { |u| @user.followed << u }
        users.map { |u| create(:post, user: u) }
      end

      it 'should return a valid response' do
        get '/api/v1/authenticated/posts', {}, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'should return all posts of users followed users' do
        get '/api/v1/authenticated/posts', {}, @auth_headers
        expect(returned_ids.length).to eql(_posts.length)
        expect(returned_ids).to match_array(_posts.map(&:id))
      end

      it 'should not return posts from unfollowed users' do
        unfollowed_post = create(:post)
        get '/api/v1/authenticated/posts', {}, @auth_headers
        expect(returned_ids).to_not include(unfollowed_post.id)
      end

    end

    context 'GET /posts/:id' do

      let!(:_post) { create(:post) }
      let!(:_protected_post) { create(:protected_post) }

      it 'should return a valid response' do
        get "/api/v1/authenticated/posts/#{_post.id}", {}, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'should return the requested post' do
        get "/api/v1/authenticated/posts/#{_post.id}", {}, @auth_headers
        expect(json[:id]).to eql(_post.id)
      end

      it 'should not allow user to request post from unfollowed, protected user' do
        get "/api/v1/authenticated/posts/#{_protected_post.id}", {}, @auth_headers
        expect(response).to have_http_status(:forbidden)
      end

      it 'should allow user to request post from followed, protected user' do
        @user.followed << _protected_post.user
        get "/api/v1/authenticated/posts/#{_protected_post.id}", {}, @auth_headers
        expect(response).to have_http_status(:success)
      end

    end

    context 'POST /posts' do

      context 'with valid params' do

        let(:_post_params) { attributes_for(:post) }

        it 'should return a valid response' do
          post '/api/v1/authenticated/posts', { post: _post_params }, @auth_headers
          expect(response).to have_http_status(:success)
        end

        it 'should create a new post' do
          expect {
            post '/api/v1/authenticated/posts', { post: _post_params }, @auth_headers
          }.to change(Post, :count).by(1)
        end

        it 'should return the created post' do
          post '/api/v1/authenticated/posts', { post: _post_params }, @auth_headers
          expect(json[:body]).to eql(_post_params[:body])
        end

      end

      context 'with invalid params' do

        let(:_invalid_post_params) { attributes_for(:post, body: nil) }

        it 'should return an invalid response' do
          post '/api/v1/authenticated/posts', { post: _invalid_post_params }, @auth_headers
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should not create a new post' do
          expect {
            post '/api/v1/authenticated/posts', { post: _invalid_post_params }, @auth_headers
          }.to_not change(Post, :count)
        end

      end

    end

    context 'PATCH /posts/:id' do

      let!(:_post) { create(:post, user: @user) }
      let!(:_body) { FFaker::HipsterIpsum.paragraph.truncate(rand(50..144), separator: /\s/, omission: '') }

      context 'with valid params' do

        it 'should return a valid response' do
          patch "/api/v1/authenticated/posts/#{_post.id}", { post: { body: _body } }, @auth_headers
          expect(response).to have_http_status(:success)
        end

        it 'should update the requested post' do
          patch "/api/v1/authenticated/posts/#{_post.id}", { post: { body: _body } }, @auth_headers
          expect(json[:body]).to eql(_body)
        end

        it 'should not allow updating another users post' do
          another_post = create(:post)
          patch "/api/v1/authenticated/posts/#{another_post.id}", { post: { body: _body } }, @auth_headers
          expect(response).to have_http_status(:forbidden)
        end

      end

      context 'with invalid params' do

        it 'should return an invalid response' do
          patch "/api/v1/authenticated/posts/#{_post.id}", { post: { body: nil } }, @auth_headers
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should not update the requested post' do
          expect {
            patch "/api/v1/authenticated/posts/#{_post.id}", { post: { body: nil } }, @auth_headers
          }.to_not change { _post.body }
        end

      end

    end

    context 'DELETE /posts/:id' do

      let!(:_post) { create(:post, user: @user) }

      it 'should return a valid response' do
        delete "/api/v1/authenticated/posts/#{_post.id}", {}, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'should mark the post as deleted' do
        delete "/api/v1/authenticated/posts/#{_post.id}", {}, @auth_headers
        expect(Post.unscoped.find(_post.id).deleted).to be_truthy
      end

      it 'should not hard delete the post' do
        expect {
          delete "/api/v1/authenticated/posts/#{_post.id}", {}, @auth_headers
        }.to_not change(Post.unscoped, :count)
      end

      it 'should not allow a user to delete anothers post' do
        another_post = create(:post)
        delete "/api/v1/authenticated/posts/#{another_post.id}", {}, @auth_headers
        expect(response).to have_http_status(:forbidden)
      end

    end

  end

  describe 'as an unauthenticated user' do

    it 'should not allow the post feed to be accessed' do
      get '/api/v1/authenticated/posts', {}, {}
      expect(response).to have_http_status(:unauthorized)
    end

    it 'should not allow the requested post to be accessed' do
      get "/api/v1/authenticated/posts/1", {}, {}
      expect(response).to have_http_status(:unauthorized)
    end

    it 'should not allow a new post to be created' do
      post '/api/v1/authenticated/posts', {}, {}
      expect(response).to have_http_status(:unauthorized)
    end

    it 'should not allow the post to be updated' do
      patch '/api/v1/authenticated/posts/1', {}, {}
      expect(response).to have_http_status(:unauthorized)
    end

    it 'should not allow the post to be marked deleted' do
      delete '/api/v1/authenticated/posts/1', {}, {}
      expect(response).to have_http_status(:unauthorized)
    end

  end

end