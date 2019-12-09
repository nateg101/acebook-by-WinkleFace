class RemoveDeviseColumnsFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :encrypted_password
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :remember_created_at
    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :authentication_token
    remove_column :users, :authentication_token_created_at
  end
end
