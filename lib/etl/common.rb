require 'epub/parser'

class LocalEpubSource
  def initialize(folder)
    @folder = folder
  end

  def each
    Dir.glob("#{folder}/*.epub") do |file|
      yield file
    end
  end

  private

  attr_reader :folder
end

class ExtractBookInfo
  def initialize
    @book_data = {}
  end

  def process(input_epub)
    @input_epub = input_epub

    book_data[:title] = parsed_book.metadata.title
    book_data[:creators] = parsed_book.metadata.creators.first.content
    book_data[:date] = parsed_book.metadata.date.content
    book_data[:publisher] = parsed_book.metadata.publishers.first.content

    parsed_book.each_page_on_spine do |page|
      print '.'
      page_plain =
        ActionView::Base.full_sanitizer.sanitize(page.content_document.read)

      book_data[:content] = (book_data[:content] || '') + page_plain
    end

    book_data
  end

  private

  attr_reader :book_data, :input_epub

  def parsed_book
    EPUB::Parser.parse(input_epub)
  end
end

