class User < ApplicationRecord
  include Clearance::User

  has_many :book_lists, dependent: :destroy

  self.implicit_order_column = "created_at"
end
