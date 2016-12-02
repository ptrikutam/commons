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

class PageContentExtractor
  def initialize(parsed_book)
    @book_text = ''
    @parsed_book = parsed_book
  end

  def start
    parsed_book.each_page_on_spine do |page|
      print '.'
      parsed_xml = page.content_document.read
      page_plain = ActionView::Base.full_sanitizer.sanitize(parsed_xml)
      @book_text = (@book_text || '' ) + page_plain
    end

    @book_text
  end

  private

  attr_reader :parsed_book
end

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

