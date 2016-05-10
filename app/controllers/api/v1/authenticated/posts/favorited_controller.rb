class Api::V1::Authenticated::Posts::FavoritedController < AuthenticatedController

  before_action :fetch_post
  before_action :authorize_action

  def create
    @favorited = FavoritedPost.new(post: @post, user: current_user)
    if @favorited.save
      render json: @post.reload, status: :accepted
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    favorited = FavoritedPost.find_by(post: @post, user: current_user)
    if favorited.try(:destroy)
      head :accepted
    else
      head :not_acceptable
    end
  end

  private

  def fetch_post
    @post = Post.find(params[:id])
  end

  def authorize_action
    raise Pundit::NotAuthorizedError unless Post::FavoritedPolicy.new(current_user, @post).send("#{self.action_name}?")
  end

end