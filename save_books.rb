require 'json'

module SaveBooksData
  def save_books(books)
    books_list = []
    return unless File.exist?('./books.json')
    books.each do |book|
      books_list << {title: book.title, author: book.author}
    end
    File.write('./books.json', JSON.generate(books_list))
  end

  def get_books
    books_list = []
    return books_list unless File.exist?('./books.json') && File.read('./books.json') != ''
      JSON.parse(File.read(books.json)).each do |book|
        books_list << Book.new(book['title'], book['author'])
      end
      books_list
  end
end