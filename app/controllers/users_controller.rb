class UsersController < ApplicationController
  def index
    @users = User.includes(:posts, :followers, :followings).all
    render json: @users, include: [ :posts, :followers, :followings ]
  end

  def show
    @user = User.includes(:posts, :followers, :followings).find(params[:id])
    render json: @user, include: [ :posts, :followers, :followings ]
  end


  def create
    @user  = User.new(create_user_paramters)
    if @user.save
      render json: @user, status: :created   # created => 201 http status code
    else
      render json: { message: "Failed to create User" }, status: :unprocessable_entity
    end
  end

  # user: {
  #   name: 'John',
  #   email: 'john@example.com',
  #   password: 'password@123',
  #   birth_date: '1990-01-01',
  #   mobile_number: '9876543210',
  #   gender: 'male'
  # }
  # require => user   permit => feilds permitted inside user
  def create_user_paramters
    params.require(:user).permit(:name, :email, :password, :birth_date, :gender, :mobile_number)
  end


  def update
    @user = User.find(params[:id])
    if @user.update(update_user_parameters)
      render json: { message: "User profile is Updated" }, status: :ok
    else
      render json: { message: "User profile is not updated" }, status: :unprocessable_entity
    end
  end

  def update_user_parameters
    params.require(:user).permit(:name, :birth_date, :gender)
  end

  def destroy
    @user = User.find(parmas[:id])
    if @user.destroy
      render json: { message: "User is Destroyed Succesfully " }, status: :ok
    else
      render json: { message: "Oops Something wnet Wrong" }, status: :internal_server_error
    end
  end
end
