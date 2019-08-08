class LikesController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]

  def new
	@gossip = Gossip.all.find(params[:gossip_id])
	@like = Like.new
  end




  def create
    # if already_liked?
      
    # else
    @gossip = Gossip.all.find(params[:gossip_id])
    @gossip.likes.create(user: current_user)
    # end
    redirect_back fallback_location: gossips_path
  end

  def destroy
  	@like = Like.all.find(post_params[:id])
	@gossip = Gossip.find(params[:gossip_id])
	@like.destroy
    redirect_back fallback_location: gossips_path
  end


  private

  	def authenticate_user
	    unless current_user
	      flash[:danger] = "Please log in."
	      redirect_to new_session_path
	    end
  	end
#   def find_gossip
#     @gossip = Gossip.find(params[:gossip_id])
#   end

#   def already_liked?
#     Like.where(user_id: current_user.id, gossip_id:
#     params[:gossip_id]).exists?
#   end

#   def find_like
#     @like = @gossip.likes.find(post_params[:id])
#  end

 def post_params
 	params.require(:like).permit(:id)
 	
   end
end