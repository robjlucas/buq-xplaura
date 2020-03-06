module BookListsHelper
  def format_author_name(book)
    "#{book["first_name"]} #{book["last_name"]}"
  end
end
