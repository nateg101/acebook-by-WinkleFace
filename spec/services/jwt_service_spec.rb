require 'rails_helper'
RSpec.describe JwtService do

  let(:jwt) { double(:jwt, decode: 'result') }

  describe 'encode' do
    it 'passes the payload and params to JWT gem' do
      payload = { user_id: 1, exp: 24.hours.from_now.to_i }
      expect(jwt).to receive(:encode).with(payload, Rails.application.secrets.secret_key_base, 'HS256')
      JwtService.encode(payload, jwt)
    end
  end

  describe 'decode' do
    it 'passes the token and params to JWT gem' do
      token = 'token'
      expect(jwt).to receive(:decode).with(token,
                                           Rails.application.secrets.secret_key_base,
                                           true,
                                           algorithm: 'HS256')
      JwtService.decode(token, jwt)
    end

    it 'passes the token and params to JWT gem' do
      token = 'token'
      expect(JwtService.decode(token, jwt)).to eq HashWithIndifferentAccess.new('result')
    end
  end

end
