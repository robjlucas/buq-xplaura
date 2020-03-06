class BookListUploadNotificationJob < ApplicationJob
  queue_as :default

  def perform(book_list)
    service = UploadNotificationService.new(book_list: book_list)
    service.process
  end
end
