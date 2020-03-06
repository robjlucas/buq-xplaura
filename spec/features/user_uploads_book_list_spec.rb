require "rails_helper"
require "support/features/clearance_helpers"
require "support/features/notice_helpers"

RSpec.feature "User uploads book list" do
  let(:valid_file_path) { Rails.root.join("spec/support/files/valid_book_list.csv") }
  let(:valid_file) { File.open(valid_file_path) }
  let(:invalid_file_path) { Rails.root.join("spec/support/files/invalid_book_list.csv") }
  let(:invalid_file) { File.open(invalid_file_path) }

  scenario "new user signs up and uploads valid book list" do
    sign_up_with "valid@example.com", "password"

    expect_user_to_be_signed_in
    expect_signed_in_user_to_be_redirected

    fill_in "List name", with: "Some book list"
    attach_file "Upload CSV file", valid_file_path
    click_button "Save Book list"

    expect(page).to have_css("h1", text: "Some book list")
    expect(page).to have_css("table.book-list")

    csv = CSV.parse(valid_file, headers: true)
    expect(page).to have_content(csv.first["isbn"])

    click_on "My book lists"
    expect(page).to have_css("a", text: "Some book list")
  end

  scenario "existing user signs in and uploads valid book list" do
    create_user "user.name@example.com", "password"
    sign_in_with "user.name@example.com", "password"

    expect_user_to_be_signed_in
    expect_signed_in_user_to_be_redirected

    fill_in "List name", with: "Some book list"
    attach_file "Upload CSV file", valid_file_path
    click_button "Save Book list"

    expect(page).to have_css("h1", text: "Some book list")
    expect(page).to have_css("table.book-list")
    
    csv = CSV.parse(valid_file, headers: true)
    expect(page).to have_content(csv.first["title"])

    click_on "My book lists"
    expect(page).to have_css("a", text: "Some book list")
  end

  scenario "user signs up and tries to upload invalid book list" do
    sign_up_with "valid@example.com", "password"

    expect_user_to_be_signed_in
    expect_signed_in_user_to_be_redirected

    fill_in "List name", with: "Some book list"
    attach_file "Upload CSV file", invalid_file_path
    click_button "Save Book list"

    expect(page).not_to have_css("h1", text: "Some book list")
    expect(page).to have_content("File Validation error for book title")
  end

  private

  def create_user(email, password)
    FactoryBot.create(:user, email: email, password: password)
  end
end
