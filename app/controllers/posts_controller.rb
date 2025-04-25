class PostsController < ApplicationController
  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def create
    @post = Post.new(create_post_parameters)
    if @post.save
      render json: { message: "New Post Created", post: @post }, status: :ok
    else
      render json: { message: "Unable to Create new Post" }, status: :unprocessable_entity
    end
  end


  # "post": {
  #   "title": "New Post Title",
  #   "content": "This is the content of the post.",
  #   "user_id": 1,     // ID of the user who created the post
  #   "category_id": 2  // ID of the category the post belongs to
  # }

  def create_post_parameters
    params.require(:post).permit(:title, :content, :user_id, :category_id)
  end

  def destroy
    @post = Post.find(parmas[:id])
    if @post.destroy
      render json: { message: "Post is Destroyed Succesfully " }, status: :ok
    else
      render json: { message: "Oops Something wnet Wrong" }, status: :internal_server_error
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(update_post_parameter)
      render json: { message: "Post is Updated" }, status: :ok
    else
      render json: { message:  "Post did not updated " }, status: :unprocessable_entity
    end
  end

  def update_post_parameter
    params.require(:post).permit(:title, :content, :category_id)
  end
end
