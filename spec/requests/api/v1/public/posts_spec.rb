require 'rails_helper'

RSpec.describe "Api::V1::Public::Posts", type: :request do

  describe "GET /posts" do

    let!(:_posts) { create_list(:post, 5) }

    it "should return a valid response" do
      get '/api/v1/public/posts'
      expect(response).to have_http_status(:success)
    end

    it 'should return all created posts' do
      get '/api/v1/public/posts'
      expect(json.length).to eql(_posts.length)
    end

    it "should not return deleted posts" do
      deleted_post = create(:post, deleted: true)
      get '/api/v1/public/posts'
      ids = json.map { |p| p[:id] }
      expect(ids).to_not include(deleted_post.id)
    end

    it "should not return posts from protected users" do
      protected_user = create(:confirmed_user, profile: create(:protected_profile))
      protected_post = create(:post, user: protected_user)
      get '/api/v1/public/posts'
      ids = json.map { |p| p[:id] }
      expect(ids).to_not include(protected_post.id)
    end

  end

  describe "GET /posts/:id" do

    let!(:_post) { create(:post) }

    it "should return a valid response" do
      get "/api/v1/public/posts/#{_post.id}"
      expect(response).to have_http_status(:success)
    end

    it "should return the desired post" do
      get "/api/v1/public/posts/#{_post.id}"
      expect(json[:id]).to eql(_post.id)
    end

    it "should not return a post from a protected user" do
      protected_post = create(:protected_post)
      get "/api/v1/public/posts/#{protected_post.id}"
      expect(response).to have_http_status(:not_found)
    end
  end

end