class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :account_type, default: "current", index: true
      t.string :account_number, null: false
      t.float :balance, index: true, default: 0.0

      t.timestamps
    end
    add_index :accounts, [:user_id, :balance]
    add_index :accounts, :account_number, unique: true
  end
end
