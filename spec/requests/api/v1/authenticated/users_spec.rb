require 'rails_helper'

describe "Api::V1::Authenticated::Users", type: :request do

  describe 'as an authenticated user' do

    login

    context 'GET /users/:id' do

      let!(:_new_user) { create :user }
      let!(:_protected_user) { create :protected_user }

      it 'should return the requested users info' do
        get "/api/v1/authenticated/users/#{_new_user.handle}", {}, @auth_headers
        expect(response).to have_http_status(:success)
        expect(json[:id]).to eql(_new_user.id)
      end

      it 'should be able to fetch user by user.id' do
        get "/api/v1/authenticated/users/#{_new_user.id}", {}, @auth_headers
        expect(response).to have_http_status(:success)
        expect(json[:handle]).to eql(_new_user.handle)
      end

      it 'should return the current users info' do
        get "/api/v1/authenticated/users/me", {}, @auth_headers
        expect(response).to have_http_status(:success)
        expect(json[:id]).to eql(@user.id)
      end

      it 'should not return a protected users data' do
        get "/api/v1/authenticated/users/#{_protected_user.handle}", {}, @auth_headers
        expect(response).to have_http_status(:forbidden)
      end

      it 'should return a protected users data if followed' do
        @user.followed << _protected_user
        get "/api/v1/authenticated/users/#{_protected_user.handle}", {}, @auth_headers
        expect(response).to have_http_status(:success)
      end

    end

    context 'PATCH /users/:id' do

      it 'should be able to update user information' do
        patch "/api/v1/authenticated/users/me", { user: { email: 'foo@bar.com' } }, @auth_headers
        expect(response).to have_http_status(:success)
        expect(json[:email]).to eql('foo@bar.com')
      end

      it 'should be able to update by passing user.id' do
        patch "/api/v1/authenticated/users/#{@user.id}", { user: { email: 'foo@bar.com' } }, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'should be able to update profile information' do
        params = { user: { profile_attributes: { id: @user.profile.id, name: 'Foo Bar' } } }
        patch "/api/v1/authenticated/users/me", params, @auth_headers
        expect(json[:name]).to eql('Foo Bar')
      end

      it 'should not be able to update another users information' do
        other_user = create(:user)
        patch "/api/v1/authenticated/users/#{other_user.id}", { user: { email: 'foo@bar.com' } }, @auth_headers
        expect(response).to have_http_status(:forbidden)
      end

    end

  end

  context 'as an unauthenticated user' do

  end
end