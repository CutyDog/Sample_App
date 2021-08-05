class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @user = current_user
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @talks = current_user.talks.page(params[:talks_page])
    end  
  end

  def help
  end
  
  def about
  end
  
  def contact
  end  
end
