class User < ApplicationRecord
  validates :user_id, presence: true
  validates :password, presence: true
  has_many :photos, dependent: :destroy
  
  has_secure_password
end
