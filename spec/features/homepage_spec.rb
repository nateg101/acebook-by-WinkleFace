require 'rails_helper'

RSpec.feature 'Homepage' do
  scenario 'unauthenticated user cant access posts url' do
    visit '/posts'
    expect(current_path).to eq '/'
  end

  scenario 'authenticate user is redirect to posts url' do
    log_in_test_user
    id = User.find_by(email: 'test@example.com').id
    visit '/'
    expect(current_path).to eq "/mrtest"
  end
end
