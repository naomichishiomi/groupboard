class Member < ApplicationRecord
 
  
  validates :group_id, presence: true
  validates :number, presence: true
  validates :member_name, presence: true, length: { maximum: 255 },uniqueness: { case_sensitive: false }
  
  has_secure_password
  belongs_to :group
  
  has_many :comments, dependent: :delete_all
end
