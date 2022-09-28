require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'

class App
  attr_accessor :book_list, :people

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

  def create_student(age, classroom, name)
    class_room = Classroom.new(classroom)
    student = Student.new(age, class_room, name)
    @people << student unless @people.include?(student)
  end

  def create_teacher(age, specialization, name)
    teacher = Teacher.new(age, specialization, name)
    @people << teacher unless @people.include?(teacher)
  end

  def list_all_people
    @people.empty? ? "The list is empty, add some people..." : @people.each { |person| puts person.name }
  end
end
