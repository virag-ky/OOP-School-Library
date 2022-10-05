require 'json'

module SaveBooksData
  def save_books(books)
    books_list = []
    file = './books.json'
    return unless File.exist?(file)

    books.each do |book|
      books_list << { title: book.title, author: book.author }
    end
    File.write(file, JSON.generate(books_list))
  end

  def load_books
    books_list = []
    file = './books.json'
    return books_list unless File.exist?(file) && File.read(file) != ''

    JSON.parse(File.read(file)).each do |book|
      books_list << Book.new(book['title'], book['author'])
    end
    books_list
  end
end
