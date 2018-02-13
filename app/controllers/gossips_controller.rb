class GossipsController < ApplicationController
	def index
		if moussaillon_signed_in?
			@gossips = Gossip.all
		else
			flash[:danger] = 'Vous devez vous connecter pour voir les gossips'
			redirect_to root_path
		end
	end

	def new
		if moussaillon_signed_in?
			@gossip = Gossip.new
		else
			flash[:danger] = 'Vous devez vous connecter pour créer un nouveau gossip'
			redirect_to root_path
		end
	end

	def create
		@moussaillon = current_moussaillon
		@gossip = @moussaillon.gossips.new(gossip_params)
  	# @gossip.creator = ?
  	if @gossip.save
  		flash[:success] = "Le gossip a bien été créé !"
  		redirect_to gossips_path
  		@gossip.creator = @current_moussaillon
  		@gossip.save
  	else
  		render 'new'
  		flash.now[:danger] = "Un problème est survenu. L'événement n'a pas été créé"
  	end
  end

  def destroy
  	@gossip = Gossip.find(params[:id])
  	if @gossip.creator == current_moussaillon
  		@gossip.destroy
  		flash[:success] = 'le gossip a bien été supprimé !'
  		redirect_to gossips_path
  	else
  		flash[:danger] = "Vous n'etes pas le créateur de ce gossip."
  		redirect_to gossips_path
  	end
  end

  private
  def gossip_params
  	params.require(:gossip).permit(:content)
  end
end
