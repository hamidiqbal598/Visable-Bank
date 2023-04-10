class CreateFundsService
  attr_reader :amount, :purpose, :account_sender_id, :account_recipient_id, :sender_id, :recipient_id

  def initialize(transaction_params)
    @amount = (transaction_params["amount"]).to_f
    @purpose = transaction_params["purpose"]
    @account_sender_id = transaction_params["sender_account_number"]
    @account_recipient_id = transaction_params["recipient_account_number"]
  end


  def call
    recipient_account = Account.find_by(account_number: @account_recipient_id)
    sender_account = Account.find_by(account_number: @account_sender_id)
    if (sender_account.balance - @amount) >= 0.0
      transaction = Transaction.new(amount: @amount,
                      purpose: @purpose,
                      sender_id: sender_account.user_id,
                      recipient_id: recipient_account.user_id,
                      account_recipient_id: recipient_account.account_number,
                      account_sender_id: sender_account.account_number)
      if transaction.save!
        ActiveRecord::Base.transaction do
          transaction.account_sender.decrement_account_balance(@amount)
          transaction.account_recipient.increment_account_balance(@amount)
        end
      end
    else
      raise "Money exceed the current Balance"
    end
    return transaction
  end


end