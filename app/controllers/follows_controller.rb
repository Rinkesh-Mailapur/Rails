class FollowsController < ApplicationController
  def create
    follower = User.find(params[:follower_id])
    followed = User.find(params[:followed_id])

    if follower.id == followed.id
      return render json: { error: "You cannot follow yourself" }, status: :unprocessable_entity
    end

    if Follow.exists?(follower: follower, followed: followed)
      render json: { message: "Already following this user" }, status: :unprocessable_entity
    else
      follow = Follow.create(follower: follower, followed: followed)
      render json: follow, status: :created
    end
  end

  def destroy
    follower = User.find(params[:follower_id])
    followed = User.find(params[:followed_id])

    follow = Follow.find_by(follower: follower, followed: followed)

    if follow
      follow.destroy
      render json: { message: "Unfollowed successfully" }, status: :ok
    else
      render json: { error: "Follow relationship not found" }, status: :not_found
    end
  end

  def followers
    user = User.find(params[:id])
    render json: user.followers
  end

  def following
    user = User.find(params[:id])
    render json: user.following
  end
end
