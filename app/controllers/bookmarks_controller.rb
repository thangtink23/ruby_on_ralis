class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]

  # GET /bookmarks
  # GET /bookmarks.json
   # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
  end
  def index
    bookmarks = Bookmark.where(user_id: current_user.id)

    @bookmarks = []

    bookmarks.each do |bookmark|
      @bookmarks.push(bookmark.review)
    end
  end



  # POST /bookmarks
  # POST /bookmarks.json
  def create
    @bookmark = Bookmark.new(bookmark_param)
    review = Review.find_by(id: params[:bookmark][:review_id])
    if @bookmark.save
      redirect_to :back
    else
      render 'new'
    end
  end
  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark = Bookmark.find_by(id: params[:bookmark][:bookmark_id])
    review = @bookmark.review
    Bookmark.delete(@bookmark.id)
    redirect_to :back
  end


    # Never trust parameters from the scary internet, only allow the white list through.
  def bookmark_param
    params.require(:bookmark).permit(:user_id, :review_id)
  end
end
