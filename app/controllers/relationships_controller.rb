class RelationshipsController < ApplicationController
  
  # follower_id：フォローする側
  # followed_id：フォローされる側
  
  def follows # フォローした人全員表示！
    @follows_relationships = Relationship.where(follower_id: params[:user_id])
    @users = User.all
  end
  
  def followers # フォローしてきた人全員表示！
    @followers_relationships = Relationship.where(followed_id: params[:user_id])
    @users = User.all
  end
  
  def create
    user = User.find(params[:user_id])
    relationship = Relationship.new(follower_id: current_user.id)
    relationship.followed_id = user.id
    relationship.save
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    relationship = Relationship.find_by(follower_id: current_user.id)
    relationship.destroy
    redirect_back(fallback_location: root_path)
  end
  
  def follower_to_followeds
    user = User.find(params[:id])
    @users = user.follower_to_followeds
  end

  def followed_to_followers
    user = User.find(params[:id])
    @users = user.followed_to_followers
  end
  
  private
  
  def relationship_params
    params.require(relationship).permit(:follower_id, :followed_id)
  end
  
end
