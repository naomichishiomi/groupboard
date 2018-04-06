class Group < ApplicationRecord
  validates :group_name, presence: true, length: { maximum: 255 },
                         format: { with: /\A[a-zA-Z0-9]+\z/ },
                         uniqueness: { case_sensitive: false }
  
  has_secure_password
end
