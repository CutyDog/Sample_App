class TalksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_member, only: [:show, :messages]
  
  def show
    @messages = @talk.messages
    @message = Message.new
    respond_to do |format|
      format.html
      format.json { render json: @messages }  
    end  
  end 
  
  def create
    @talk = Talk.new
    @talk.memberships.build(user_id: current_user.id)
    @talk.memberships.build(user_id: params[:member_id])
    @talk.save
    if @talk.save
      redirect_to talk_path(@talk)
    end  
  end
  
  def messages
    @message = Message.new(message_params)
    #トークの更新日時を更新
    @talk.touch
    if @message.save
      redirect_to @talk
    else
      @messages = @talk.messages
      render 'show'
    end  
  end  
  
  def destroy
  end
  
  private
  
    def message_params
      params[:message].merge!({ user_id: current_user.id, talk_id: @talk.id })
      params.require(:message).permit(:user_id, :talk_id, :content)
    end  
    
    def correct_member
      @talk = current_user.talks.find_by(id: params[:id])
      redirect_to root_url if @talk.nil?
    end  
    
    def correct_user
      @message = current_user.messages.find_by(id: params[:id])
      redirect_to root_url if @message.nil?
    end

end
