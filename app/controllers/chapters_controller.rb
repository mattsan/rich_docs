class ChaptersController < ApplicationController
  before_action :load_chapter, only: [:show, :edit, :update]

  def index
    @chapters = Chapter.all
  end

  def show
  end

  def new
    @chapter = Chapter.new
  end

  def create
    @chapter = Chapter.new(chapter_params)
    if @chapter.save
      redirect_to chapters_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @chapter.update(chapter_params)
      redirect_to @chapter
    else
      render :edit
    end
  end

  def load_chapter
    @chapter = Chapter.find(params[:id])
  end

  def chapter_params
    params.require(:chapter).permit(:title, :content)
  end
end
