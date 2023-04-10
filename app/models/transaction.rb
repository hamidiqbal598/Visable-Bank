class Transaction < ApplicationRecord

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  belongs_to :account_sender, class_name: 'Account', foreign_key: 'account_sender_id', primary_key: 'account_number'
  belongs_to :account_recipient, class_name: 'Account', foreign_key: 'account_recipient_id', primary_key: 'account_number'


end
