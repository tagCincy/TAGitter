class Api::V1::Public::UsersController < ApplicationController
  before_action :fetch_user
  before_action :authorize_action

  def show
    render json: @user
  end

  private

  def fetch_user
    @user = User.find params[:id]
  end

  def authorize_action
    raise Pundit::NotAuthorizedError unless Api::V1::Public::UserPolicy.new(@user).send("#{self.action_name}?")
  end

end