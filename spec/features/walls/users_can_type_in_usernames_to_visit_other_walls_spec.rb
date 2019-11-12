require 'rails_helper'

RSpec.feature 'Walls' do
  scenario 'Navigate to someones wall with username and see their posts' do
    log_in_test_user
    submit_post('mr tests post')
    click_link 'Logout'
    log_in_test_user_2
    visit '/mrtest'
    expect(current_path).to include "/mrtest"
    expect(page).to have_content('mr tests post')
  end

end
