class AddThumbnailUrlToBookmarks < ActiveRecord::Migration[7.2]
  def change
    add_column :bookmarks, :thumbnail_url, :string
  end
end
