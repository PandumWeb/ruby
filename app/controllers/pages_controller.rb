class PagesController < ApplicationController

  def home
    @titre = "Accueil"
    if signed_in?
      @post = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page],:per_page => 5)
  end
  end

  def contact
    @titre = "Contact"
  end

  def about
    @titre = "À Propos"
  end

  def help
  	@titre = "Help"
  end
end
