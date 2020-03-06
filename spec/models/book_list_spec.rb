require 'rails_helper'

RSpec.describe BookList, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:valid_file) { File.open("spec/support/files/valid_book_list.csv") }
  let(:invalid_file) { File.open("spec/support/files/invalid_book_list.csv") }

  describe "validations" do
    context "with invalid ISBNs" do
      it "raises validation errors" do
        book_list = described_class.create(user: user, file: invalid_file)
        expect(book_list.errors[:file].first).to include("not a valid ISBN")
      end
    end

    context "with valid ISBNs" do
      it "does not raise validation errors" do
        book_list = described_class.create(user: user, file: valid_file)
        expect(book_list.valid?).to be(true)
      end
    end
  end

  describe "file retrieval" do
    it "returns a parsed CSV file" do
      book_list = described_class.create(user: user, file: valid_file)
      expect(user.book_lists.first.csv).to be_a(CSV::Table)
    end
  end
end
