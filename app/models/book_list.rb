class BookList < ApplicationRecord
  belongs_to :user

  self.implicit_order_column = "created_at"

  mount_uploader :file, FileUploader
end
