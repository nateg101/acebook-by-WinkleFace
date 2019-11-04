class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, unique: true, null: false
      t.string :forename, null: false
      t.string :surname, null: false
      t.string :password_digest, null: false
      t.string :email, null: false, unique: true
    end
  end
end
