require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.create(username: 'username', password: 'password', email: 'email@email.com') }
  let(:owned_object) { double(:owned_object, user: subject) }
  let(:unowned_object) { double(:owned_object, user: nil) }

  describe '#owns?' do
    it 'returns true' do
      expect(subject.owns?(owned_object)).to eq true
    end
    
    it 'returns false' do
      expect(subject.owns?(unowned_object)).to eq false
    end
  end
end
