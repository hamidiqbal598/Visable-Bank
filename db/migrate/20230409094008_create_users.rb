class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, index: true
      t.string :email, index: true
      t.string :username, index: true
      t.string :authentication_token, index: true

      t.timestamps
    end
    add_index :users, [:username, :authentication_token]
  end
end
