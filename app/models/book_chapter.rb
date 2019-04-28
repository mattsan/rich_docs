class BookChapter < ApplicationRecord
  belongs_to :book
  belongs_to :chapter
end
