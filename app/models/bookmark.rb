class Bookmark < ApplicationRecord
  belongs_to :user
  validates :url, presence: true,
    format: URI::DEFAULT_PARSER.make_regexp(%w[http https])

  scope :search, ->(q) {
    where("title ILIKE :q OR memo ILIKE :q", q: "%#{sanitize_sql_like(q)}%")
  }
end
