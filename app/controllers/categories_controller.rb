class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    render json: @categories
  end

  def show
    @category = Category.find(params[:id])
    render json: @category
  end

  def create
    @category = Category.new(category_parameter)
    if @category.save
      render json: @category, status: :created   # created => 201 http status code
    else
      render json: { message: "Failed to create Category" }, status: :unprocessable_entity
    end
  end

  def category_parameter
    params.require(:category).permit(:cat_name)
  end

  def destroy
    @category = Category.find(parmas[:id])
    if @category.destroy
      render json: { message: "Category is Destroyed Succesfully " }, status: :ok
    else
      render json: { message: "Oops Something wnet Wrong" }, status: :internal_server_error
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_parameter)
      render json: { message: "Category Updated" }, status: :ok
    else
      render json: { message: "Category is not updated" }, status: :unprocessable_entity
    end
  end
end
