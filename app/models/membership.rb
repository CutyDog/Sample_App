class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :talk
  validates :user_id, uniqueness: { scope: :talk_id }
  after_destroy :destroy_empty_talk
  
  
  private
  
    def destroy_empty_talk
      talk.destroy if talk.reload.memberships.empty?
    end  
  
end  