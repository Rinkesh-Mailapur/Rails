class LikesController < ApplicationController
  skip_before_action :verify_authenticity_token


  def index
    if params[:post_id].present?
      @post = Post.find_by(id: params[:post_id])
      if @post
        @likes = @post.likes
        render json: @likes
      else
        render json: { message: "Post not found" }, status: :not_found
      end
    elsif params[:comment_id].present?
      @comment = Comment.find_by(id: params[:comment_id])
      if @comment
        @likes = @comment.likes
        render json: @likes
      else
        render json: { message: "Comment not found" }, status: :not_found
      end
    else
      render json: { message: "No post or comment ID provided" }, status: :unprocessable_entity
    end
  end


  def show
    @like = Like.find_by(id: params[:id])
    if @like
      render json: @like
    else
      render json: { message: "Like not found" }, status: :not_found
    end
  end


  def create
    if params[:post_id].present?
      post = Post.find_by(id: params[:post_id])
      if post
        like = post.likes.create(user_id: params[:user_id])
      else
        render json: { message: "Post not found" }, status: :not_found
        return
      end
    elsif params[:comment_id].present?
      comment = Comment.find_by(id: params[:comment_id])
      if comment
        like = comment.likes.create(user_id: params[:user_id])
      else
        render json: { message: "Comment not found" }, status: :not_found
        return
      end
    else
      render json: { message: "Invalid parameters: No post or comment provided" }, status: :unprocessable_entity
      return
    end

    if like.persisted?
      render json: { like: like, message: "Like created successfully" }, status: :created
    else
      render json: { errors: like.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Destroy Action: Remove a Like
  def destroy
    @like = Like.find_by(id: params[:id])
    if @like && @like.destroy
      render json: { message: "Like deleted successfully" }, status: :ok
    else
      render json: { message: "Like not found or unable to delete" }, status: :unprocessable_entity
    end
  end

  private

  # Strong Parameters for Like creation
  def like_params
    params.require(:like).permit(:post_id, :comment_id, :user_id)
  end
end
