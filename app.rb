require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'

class App
  attr_accessor :book_list

  def initialize
    @book_list = []
    @people = []
    @rentals = []
  end

  def run
    prompt_user
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @book_list << book unless @book_list.include?(book)
  end

  def list_all_books
    @book_list.empty? ? "The list is empty, add some books..." : @book_list.each { |book| puts book.title }
  end
end
