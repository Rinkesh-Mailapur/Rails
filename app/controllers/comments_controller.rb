class CommentsController < ApplicationController
  def index
    @comments = Comment.all
    render json: @comments
  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end

  def create
    @comment = Comment.new(comment_parameter)
    if @comment.save
      render json: { message: "New Comment created", comment: @comment }, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def comment_parameter
    params.require(:comment).permit(:message, :post_id, :user_id)
  end


  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render json: { message: "Comment deleted successfully" }, status: :ok
    end
  end
end
