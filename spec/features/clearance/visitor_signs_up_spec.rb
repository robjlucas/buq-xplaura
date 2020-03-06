require "rails_helper"
require "support/features/clearance_helpers"
require "support/features/notice_helpers"

RSpec.feature "Visitor signs up" do
  scenario "by navigating to the page" do
    visit sign_in_path

    click_link "Sign up"

    expect(current_path).to eq sign_up_path
  end

  scenario "with valid email and password" do
    sign_up_with "valid@example.com", "password"

    expect_user_to_be_signed_in
    expect_signed_in_user_to_be_redirected
  end

  scenario "tries with invalid email" do
    sign_up_with "invalid_email", "password"

    expect(page).to have_css("#user_email[value='invalid_email']")
    expect_user_to_be_signed_out
  end
end
