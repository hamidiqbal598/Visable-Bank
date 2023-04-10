class User < ApplicationRecord

  has_many :accounts, dependent: :destroy
  has_many :sender_transactions, class_name: 'Transaction', foreign_key: 'sender_id'
  has_many :recipient_transactions, class_name: 'Transaction', foreign_key: 'recipient_id'

  validates :name, :email, :authentication_token, :username, presence: true

  scope :get_user, -> (username, token) { where(username: username, authentication_token: token) }

end
