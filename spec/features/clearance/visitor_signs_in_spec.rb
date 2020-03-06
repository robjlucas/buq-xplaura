require "rails_helper"
require "support/features/clearance_helpers"
require "support/features/notice_helpers"

RSpec.feature "Visitor signs in" do
  scenario "with valid email and password" do
    create_user "user@example.com", "password"
    sign_in_with "user@example.com", "password"

    expect_user_to_be_signed_in
    expect_signed_in_user_to_be_redirected
  end

  scenario "with valid mixed-case email and password " do
    create_user "user.name@example.com", "password"
    sign_in_with "User.Name@example.com", "password"

    expect_user_to_be_signed_in
    expect_signed_in_user_to_be_redirected
  end

  scenario "tries with invalid password" do
    create_user "user@example.com", "password"
    sign_in_with "user@example.com", "wrong_password"

    expect_page_to_display_sign_in_error
    expect_user_to_be_signed_out
  end

  scenario "tries with invalid email" do
    sign_in_with "unknown.email@example.com", "password"

    expect_page_to_display_sign_in_error
    expect_user_to_be_signed_out
  end

  scenario "tries without password or email", :run_jobs do
    sign_in_with "", ""

    expect(page).to show_alert("Bad email or password.")
    expect_user_to_be_signed_out
  end

  private

  def create_user(email, password)
    FactoryBot.create(:user, email: email, password: password)
  end

  def expect_page_to_display_sign_in_error
    expect(page).to show_alert("Bad email or password.")
  end
end
