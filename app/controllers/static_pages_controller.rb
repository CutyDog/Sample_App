class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @user = current_user
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @feed_items_all = current_user.feed
      @talks = current_user.talks.page(params[:talks_page])
      @talks_all = current_user.talks
      respond_to do |format|
        format.html
        format.json { render json: {user: @user, feed: @feed_items_all, talks: @talks_all}}
      end  
    end  
  end

  def help
  end
  
  def about
  end
  
  def contact
  end  
end
