class Api::V1::Authenticated::Posts::RepostsController < AuthenticatedController

  before_action :fetch_post
  before_action :authorize_action

  def create
    @repost = current_user.posts.build(repost: @post)
    if @repost.save
      render json: @repost, serializer: PostSerializer, status: :created
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  private

  def fetch_post
    @post = Post.includes(:user, :reposts).find(params[:id])
  end

  def authorize_action
    raise Pundit::NotAuthorizedError unless Post::RepostPolicy.new(current_user, @post).send("#{self.action_name}?")
  end

end