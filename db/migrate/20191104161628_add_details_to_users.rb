class AddDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :surname, :string, null: false
    add_column :users, :password_digest, :string, null: false
    add_column :users, :email, :string, unique: true, null: false
    change_column :users, :username, :string, unique: true, null: false
  end
end
