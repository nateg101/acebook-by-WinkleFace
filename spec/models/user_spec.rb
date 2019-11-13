require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.create(username: 'username', password: 'password', email: 'email@email.com') }
  let(:owned_object) { double(:owned_object, user: subject) }

  describe '#owns?' do
    it 'returns true' do
      user = FactoryBot.create(:user)
      expect(user.owns?(owned_object)).to eq false
    end
  end
end
