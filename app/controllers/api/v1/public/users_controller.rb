class Api::V1::Public::UsersController < ApplicationController
  before_action :fetch_user
  before_action :authorize_action

  def show
    render json: @user
  end

  private

  def fetch_user
    @user = User.find_by_identifier params[:id]
  end

  def authorize_action
    raise Pundit::NotAuthorizedError unless User::PublicUserPolicy.new(@user).send("#{self.action_name}?")
  end

end