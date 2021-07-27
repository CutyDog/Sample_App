class Talk < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :members, class_name: "User", through: :memberships, source: :user
  has_many :messages, dependent: :destroy
  
  
end  