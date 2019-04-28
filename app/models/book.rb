class Book < ApplicationRecord
  has_many :book_chapters
  has_many :chapters, through: :book_chapters
  has_one_attached :epub

  def attach_epub
    epub_stream = generate_epub.generate_epub_stream
    epub_stream.seek(0)
    epub.attach(io: epub_stream, filename: "#{title}.epub", content_type: 'application/epub+zip')
  end

  def generate_epub
    GEPUB::Book.new {|book|
      book.identifier = SecureRandom.hex(24)
      book.title = title

      chapters.each do |chapter|
        chapter.content.embeds.each do |embeded|
          href = "img/#{embeded.blob.id}/#{embeded.filename}"
          book.add_item(href, content: StringIO.new(embeded.blob.download))
        end
      end

      book.ordered do
        chapters.each do |chapter|
          item = book.add_item("text/#{chapter.title}.xhtml")
          item.add_content(StringIO.new(chapter.to_xhtml)).toc_text(chapter.title)
        end
      end
    }
  end
end
