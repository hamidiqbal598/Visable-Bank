

users = User.create([
                      { username: 'Nina' , authentication_token: '1btoken', name: 'Nina Graf', email: 'visable-jobs@m.personio.de'  },
                      { username: 'Benjamin' , authentication_token: '1btoken', name: 'Benjamin', email: 'visable-jobs@m.personio.de'  },
                      { username: 'Hamid' , authentication_token: '1token', name: 'Hamid Iqbal', email: 'hamidiqbal598@gmail.com'  }
                    ])

users = FactoryBot.create_list(:user, 5)
User.all.each do |user|
  accounts = FactoryBot.create_list(:account, rand(1..4), user: user)
  # users = FactoryBot.create_list(:transaction, 5, sender: user, sender_account: accounts)
end

90.times do
  sender = User.offset(rand(User.count)).first
  sender_account = sender.accounts.offset(rand(sender.accounts.count)).first

  recipient = User.where.not(id: sender.id).offset(rand(User.count - 1)).first
  recipient_account = recipient.accounts.offset(rand(recipient.accounts.count)).first

  FactoryBot.create_list(:transaction, 1,sender: sender, account_sender: sender_account, account_recipient: recipient_account, recipient: recipient)

end