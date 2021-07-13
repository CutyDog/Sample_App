class Micropost < ApplicationRecord
  belongs_to :user
  before_validation :set_in_reply_to
  default_scope -> { order(created_at: :desc) }
  scope :including_replies, -> (id){ where(in_reply_to: [id, 0]).or(Micropost.where(user_id: id)) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :in_reply_to, presence: false
  validate :picture_size
  
  
  # def Micropost.including_replies(id)
  #   where(in_reply_to: [id, 0]).or(Micropost.where(user_id: id))
  # end  
  
  def set_in_reply_to
    if @index = content.index("@")
      reply_to = []
      while (content[@index+1] != ",")&&(@index != content.length)
        @index += 1
        reply_to << content[@index]
      end 
      if user = User.find_by(name: reply_to.join.to_s)
        self.in_reply_to = user.id
      else
        errors.add(:base, "User Name you specified doesn't exist.")
        self.in_reply_to = 0
      end  
    else
      self.in_reply_to = 0
    end  
  end  
  
  
  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
