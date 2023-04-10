require 'rails_helper'

RSpec.describe Transaction, type: :model do

  describe 'associations' do
    it { should belong_to(:sender) }
    it { should belong_to(:recipient) }
    it { should belong_to(:account_sender) }
    it { should belong_to(:account_recipient) }
  end
end
