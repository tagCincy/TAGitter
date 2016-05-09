class Api::V1::Authenticated::UsersController < AuthenticatedController

  before_action :fetch_user
  before_action :authorize_action

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :accepted
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def fetch_user
    params[:id] = current_user.id if params[:id].eql?('me')
    @user = User.includes(:profile, posts: [:repost]).find_by_identifier(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :handle, :password, :password_confirmation,
                                 profile_attributes: [:id, :name, :bio, :location, :dob, :protected])
  end

  def authorize_action
    raise Pundit::NotAuthorizedError unless User::AuthenticatedUserPolicy.new(current_user, @user).send("#{self.action_name}?")
  end

end