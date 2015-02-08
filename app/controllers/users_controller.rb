class UsersController < ApplicationController
  before_filter :authenticate, :only =>[:index,:edit, :update,:destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

def index
  @titre = "Tous les membres"
  @users = User.order('nom ASC').paginate(:page => params[:page], :per_page => 20)
end
  def show
    @user = User.find(params[:id])
    @titre = @user.nom
    @microposts = @user.microposts.paginate(:page => params[:page], :per_page => 5)

  end

   def new
    @user = User.new
    @titre = "Inscription"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
    	flash[:success] = "Bienvenu sur la plateforme!"
      redirect_to @user
    else
      @titre = "Inscription"
      render 'new'
    end
  end

   def edit
    @user = User.find(params[:id])
    @titre = "Édition profil"
  end

   def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profil actualisé."
      redirect_to @user
    else
      @titre = "Édition profil"
      render 'edit'
    end
  end

   def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Utilisateur supprimé."
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:nom, :email, :password, :salt, :encrypted_password)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

     def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
  end
