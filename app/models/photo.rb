class Photo < ApplicationRecord
  validates :user_id, presence: true
  validates :title, presence: 'タイトルを入力してください', length: { maximum: 30, too_long: 'タイトルは最大30文字までです' }
  validates :image, presence: '画像ファイルを入力してください'
  
  has_one_attached :image
  
  belongs_to :user
end
