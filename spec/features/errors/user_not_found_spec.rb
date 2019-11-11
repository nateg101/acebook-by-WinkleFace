require 'rails_helper'

RSpec.feature "User not found page error" do
  scenario "" do
    log_in_test_user
    visit '/0'
    expect(current_path).to eq '/user_not_found'
  end
end
