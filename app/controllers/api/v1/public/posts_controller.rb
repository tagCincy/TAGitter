class Api::V1::Public::PostsController < ApplicationController

  before_action :fetch_post, only: [:show]
  before_action :authorize_action, only: [:show]

  def index
    render json: Post.public_posts
  end

  def show
    render json: Post.find(params[:id])
  end

  private

  def fetch_post
    @post = Post.find(params[:id])
  end

  def authorize_action
    raise Pundit::NotAuthorizedError unless Post::PublicPostPolicy.new(@post).send("#{self.action_name}?")
  end

end