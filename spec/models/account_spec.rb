require 'rails_helper'

RSpec.describe Account, type: :model do

  let(:sender) { FactoryBot.create(:user) }
  let(:account) { FactoryBot.create(:account, user: sender) }
  let(:recipient) { FactoryBot.create(:user) }
  let(:account_recipient) { FactoryBot.create(:account, user: recipient) }
  let!(:transaction1) { account.sender_transactions.create(amount: 50, sender: sender, recipient: recipient, account_sender: account, account_recipient: account_recipient) }
  let!(:transaction2) { account.sender_transactions.create(amount: 10, sender: recipient, recipient: sender, account_sender: account_recipient, account_recipient: account) }

  describe 'associations' do
    it { should have_many(:sender_transactions).dependent(:destroy) }
    it { should have_many(:recipient_transactions).dependent(:destroy) }
  end

  describe "#Requires and Checks?" do

    it "requires a account_type" do
      expect(account).to validate_presence_of(:account_type)
    end

    it 'should be one of dedicated account_type' do
      expect(account.account_type).to be_in(POSSIBLE_TYPE_OF_ACCOUNTS)
    end

    it "checks that balance is greater than 0" do
      expect(account.balance).to be >= 0
    end
  end

  describe 'dependent destroy' do
    it 'destroys associated transcations when account is destroyed' do
      expect { account.destroy }.to change(Transaction, :count).by(-2)
    end
  end


end
