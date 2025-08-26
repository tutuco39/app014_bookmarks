class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bookmark, only: %i[ show edit update destroy ]
  before_action :require_owner!, only: %i[ show edit update destroy ]

  def index
    @bookmarks = current_user.bookmarks.order(created_at: :desc)
    @bookmarks = @bookmarks.search(params[:q]) if params[:q].present?
  end

  def new
    @bookmark = current_user.bookmarks.new(url: params[:url])
  end

  def create
    @bookmark = current_user.bookmarks.new(bookmark_params)
    if @bookmark.save
      redirect_to @bookmark, notice: "Saved!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @bookmark.update(bookmark_params)
      redirect_to @bookmark, notice: "Updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to bookmarks_url, notice: "Deleted."
  end

  private
  def set_bookmark; @bookmark = Bookmark.find(params[:id]); end
  def require_owner!; redirect_to bookmarks_path, alert: "Not authorized." unless @bookmark.user_id == current_user.id; end
  def bookmark_params; params.require(:bookmark).permit(:title, :url, :memo); end
end
