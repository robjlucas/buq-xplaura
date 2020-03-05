class User < ApplicationRecord
  include Clearance::User

  has_many :book_lists, dependent: :destroy
end
