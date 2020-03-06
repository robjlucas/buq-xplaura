class BookListsController < ApplicationController
  view_accessor :book_list, :book_lists

  before_action :require_login

  def index
  end

  def show
    self.book_list = current_user.book_lists.find(params.fetch(:id))
  end

  def new
    self.book_list = BookList.new(user: current_user)
  end

  def create
    self.book_list = BookList.new(book_list_params)

    if book_list.save
      BookListUploadNotificationJob.perform_later(book_list)
      redirect_to book_list
    else
      flash[:errors] = book_list.errors.full_messages
      render :new
    end
  end

  private def book_list_params
    params
      .require(:book_list)
      .permit(:file, :user_id, :name)
  end

  private def book_lists
    @_book_lists ||= current_user.book_lists
  end
end
