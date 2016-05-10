class Api::V1::Authenticated::Users::FollowsController < AuthenticatedController

  before_action :fetch_user
  before_action :authorize_action

  def create
    @following = UserFollower.new(followed: @user, follower: current_user)
    if @following.save
      render json: @user.reload, status: :accepted
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    following = UserFollower.find_by(followed: @user, follower: current_user)
    if following.try(:destroy)
      head :accepted
    else
      head :not_acceptable
    end
  end

  private

  def fetch_user
    @user = User.find_by_identifier(params[:id])
  end

  def authorize_action
    raise Pundit::NotAuthorizedError unless User::FollowPolicy.new(current_user, @user).send("#{self.action_name}?")
  end

end