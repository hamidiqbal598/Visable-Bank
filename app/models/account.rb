class Account < ApplicationRecord

  belongs_to :user
  has_many :sender_transactions, class_name: 'Transaction', foreign_key: 'account_sender_id', primary_key: 'account_number', dependent: :destroy
  has_many :recipient_transactions, class_name: 'Transaction', foreign_key: 'account_recipient_id', primary_key: 'account_number', dependent: :destroy

  validates :account_type, presence: true, inclusion: { in: POSSIBLE_TYPE_OF_ACCOUNTS }
  validates :balance, numericality: { greater_than: -1, message: "Account Balance be greater than 0" }

  def latest_transactions
    (sender_transactions.or(recipient_transactions)).order(created_at: :desc).limit(10)
  end

  def decrement_account_balance(amount)
    decrement!(:balance, amount)
  end

  def increment_account_balance(amount)
    increment!(:balance, amount)
  end

end
