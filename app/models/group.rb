class Group < ApplicationRecord
  validates :group_name, presence: true, length: { maximum: 255 },
                         format: { with: /\A[-a-zA-Z0-9]+\z/ },
                         uniqueness: { case_sensitive: false }
  validates :role_id, presence: true
  
  
  has_many :members, dependent: :destroy
  belongs_to :role
end
