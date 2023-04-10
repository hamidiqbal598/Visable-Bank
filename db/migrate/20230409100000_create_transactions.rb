class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    # add_index :accounts, :account_number, unique: true
    create_table :transactions, id: :uuid do |t|
      t.float :amount, index: true
      t.string :purpose
      t.references :account_sender, null: false, foreign_key: {to_table: :accounts, primary_key: :account_number, column: :account_sender}, type: :string
      t.references :account_recipient, null: false, foreign_key: {to_table: :accounts, primary_key: :account_number, column: :account_recipient}, type: :string
      t.references :sender, null: false, foreign_key: {to_table: :users}, type: :uuid
      t.references :recipient, null: false, foreign_key: {to_table: :users}, type: :uuid

      t.timestamps
    end
    add_index :transactions, [:sender_id, :recipient_id]
    add_index :transactions, [:amount, :sender_id, :recipient_id]
  end
end
