class UsersController < ApplicationController

<<<<<<< HEAD
  def show
    @user = User.find(params[:id])
    @titre = @user.nom
  end

=======
	def show
		@user = User.find(params[:id])
	end
>>>>>>> modeling-users
  def new
    @title = "S'inscrire"
  end
end
