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
