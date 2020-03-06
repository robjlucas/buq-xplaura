class UploadNotificationService

  attr_accessor :book_list

  def initialize(book_list:)
    @book_list = book_list
  end

  def process
    uri = URI.parse(ENV.fetch("UPLOAD_NOTIFICATION_URL"))
    Net::HTTP.post_form(uri, id: book_list.id, name: book_list.name, url: book_list.file_url)
  end
end
