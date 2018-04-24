class Comment < ApplicationRecord
  belongs_to :member
  
  validates :member_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :groupnumber, presence: true 
end
