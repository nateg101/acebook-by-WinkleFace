require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

describe User do
  it 'creates a new user' do
    user = User.create(
      :forename => 'Joe',
      :surname => 'Bloggs',
      :email => 'noddy@hotmail.com',
      :username => 'JoeBloggs',
      :password_digest => 'password123',
      :password_confirmation => 'password123'
    )
    expect(user).to be_a User
    expect(user.username).to eq 'JoeBloggs'
    expect(user.email).to eq 'noddy@hotmail.com'
    expect(user.forename).to eq 'Joe'
  end
end
