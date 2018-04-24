class AdminForm
  include ActiveModel::Model

  # Formで使用するプロパティを定義する
  attr_accessor :name, :count, :admin_name, :password

  # Validationを定義する
  validates :name, presence: true, length: { maximum: 255 },format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :count, presence: true
  validates :admin_name, presence: true
  validates :password, presence: true

end