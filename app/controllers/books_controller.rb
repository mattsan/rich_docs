class BooksController < ApplicationController
  before_action :load_book, only: [:show]

  def index
    @books = Book.all
  end

  def show
  end

  def load_book
    @book = Book.find(params[:id])
  end
end
