class CreateBookmarks < ActiveRecord::Migration[7.2]
  def change
    create_table :bookmarks do |t|
      t.string :title
      t.text :url
      t.text :memo
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
