class Micropost < ApplicationRecord
  belongs_to :user
  before_validation :set_in_reply_to
  default_scope -> { order(created_at: :desc) }
  scope :including_replies, -> (id){ where(in_reply_to: [id, 0])
                                      .or(Micropost.where(user_id: id)) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :in_reply_to, presence: true
  validate :picture_size

  
  def set_in_reply_to
    @reply_to = []
    
    if @index = content.index("@")
      while (content[@index+1] != ",")
        @index += 1
        @reply_to << content[@index]
      end
      if user = User.find_by(name: @reply_to.join.to_s)
        update_attribute(:in_reply_to, user.id)
      end
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
