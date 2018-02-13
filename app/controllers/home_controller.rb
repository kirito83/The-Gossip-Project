class HomeController < ApplicationController
  def index
  	if moussaillon_signed_in?
  		redirect_to gossips_path
  	end
  end
end
