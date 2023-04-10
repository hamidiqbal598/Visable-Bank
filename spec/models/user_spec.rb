require 'rails_helper'

RSpec.describe User, type: :model do

  describe "#Requires?" do

    let(:user) { create(:user) }

    it "requires a name" do
      expect(user).to validate_presence_of(:name)
    end

    it "requires a email" do
      expect(user).to validate_presence_of(:email)
    end

    it "requires a username" do
      expect(user).to validate_presence_of(:username)
    end

    it "requires a authentication_token" do
      expect(user).to validate_presence_of(:authentication_token)
    end
  end

  describe 'authentication' do
    let(:user) { User.create(email: 'hamidtest1@gmail.com', authentication_token: '1btoken') }

    it 'authenticates with correct password' do
      expect(user.authentication_token).to eq('1btoken')
    end

    it 'does not authenticate with incorrect password' do
      expect(user.authentication_token).not_to eq('wrong')
    end
  end

end
