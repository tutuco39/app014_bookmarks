module BookmarksHelper
  def bookmark_thumb(bookmark)
    # 文字列参照のカラムを優先。無ければ public/images から適当に拾う or プレースホルダー
    return bookmark.thumbnail_url if bookmark.respond_to?(:thumbnail_url) && bookmark.thumbnail_url.present?

    files = Dir.glob(Rails.root.join("public/images/*.{jpg,jpeg,png,gif}"))
    return "/images/#{File.basename(files.sample)}" if files.any?

    "https://placehold.co/1200x630/7C4DFF/FFFFFF?text=Bookmark"
  end

  def display_date(date)
    l(date.to_date, format: :long) rescue date.strftime("%b %d, %Y")
  end
end
