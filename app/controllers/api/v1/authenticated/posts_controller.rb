class Api::V1::Authenticated::PostsController < AuthenticatedController

  before_action :fetch_post, only: [:show, :update, :destroy]
  before_action :authorize_action

  def index
    render json: Post.user_feed(current_user)
  end

  def show
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post, status: :accepted
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    head :ok if @post.destroy
  end

  private

  def fetch_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body)
  end

  def authorize_action
    raise Pundit::NotAuthorizedError unless Post::AuthenticatedPostPolicy.new(current_user, @post).send("#{self.action_name}?")
  end

end