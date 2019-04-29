class EpubsController < ApplicationController
  before_action :load_book

  def show
    respond_to do |format|
      format.html
      format.epub { send_data @book.epub.download, filename: @book.epub.filename.to_s }
    end
  end

  def create
    @book.attach_epub
    redirect_to @book
  end

  def load_book
    @book = Book.find(params[:book_id])
  end
end
