class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :photo

  validates :user_id, presence: true
  validates :content, length: { maximum: 200 }
  validates :photo, content_type: ['image/png', 'image/jpg', 'image/jpeg']
  validates :photo, attached: true, size: { less_than: 3.megabytes, message: 'is not given between size' }
end
