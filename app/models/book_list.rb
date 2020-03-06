class BookList < ApplicationRecord

  ISBN10_REGEX = /^(?:\d[\ |-]?){9}[\d|X]$/i.freeze
  ISBN13_REGEX = /^(?:\d[\ |-]?){13}$/i.freeze

  belongs_to :user

  self.implicit_order_column = "created_at"

  mount_uploader :file, FileUploader

  validates :name, :file, :user_id, presence: true
  validate :check_isbns

  private def check_isbns
    if file.read.present?
      csv = CSV.parse(file.read, headers: true)

      csv.each do |book|
        unless valid_isbn?(book["isbn"])
          errors.add(:file, "Validation error for book title '#{book["title"]}': #{book["isbn"]} is not a valid ISBN")
        end
      end
    end
  end

  private def valid_isbn?(isbn)
    (isbn&.match(ISBN10_REGEX).present? || isbn&.match(ISBN13_REGEX).present?)
  end
end
