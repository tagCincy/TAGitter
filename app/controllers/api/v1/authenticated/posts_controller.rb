class Api::V1::Authenticated::PostsController < AuthenticatedController

  def index
    render json: Post.user_feed
  end

  def show
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    if @post.create
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

end