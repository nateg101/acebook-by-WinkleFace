require 'rails_helper'

RSpec.feature "Timeline", type: :feature do
  scenario "User tries to edit a created comment after 15 minutes" do
    log_in_test_user
    time_of_post = Time.local(2019, 9, 1, 12, 0, 0)
    Timecop.freeze(time_of_post)
    submit_post("Comment on me and edit me")
    add_comment
    Timecop.return
    new_time = Time.local(2019, 9, 1, 12, 15, 0)
    Timecop.freeze(new_time)
    expect(page).not_to have_link 'Edit Comment'

  end
end
