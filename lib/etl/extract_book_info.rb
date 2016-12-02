require 'epub/parser'

class ExtractBookInfo
  def initialize
    @book_data = { metadata: {} }
  end

  def process(input_epub)
    @input_epub = input_epub

    book_data[:title] = parsed_book.metadata.title
    book_data[:metadata][:creators] = parsed_book.metadata.creators.first.content
    book_data[:metadata][:date] = parsed_book.metadata.date.content
    book_data[:metadata][:publisher] =
      parsed_book.metadata.publishers.first.content
    book_data[:metadata][:content] = PageContentExtractor.new(parsed_book).start

    book_data
  end

  private

  attr_reader :book_data, :input_epub

  def parsed_book
    EPUB::Parser.parse(input_epub)
  end
end
