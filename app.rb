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
    @students = []
    @teachers = []
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
    @book_list.empty? ? 'The list is empty, add some books...' : @book_list.each { |book| puts "Title: '#{book.title}', Author: #{book.author} " }
  end

  def create_student(age, classroom, name)
    class_room = Classroom.new(classroom)
    student = Student.new(age, class_room, name)
    @people << student unless @people.include?(student)
    @students << student unless @students.include?(student)
  end

  def create_teacher(age, specialization, name)
    teacher = Teacher.new(age, specialization, name)
    @people << teacher unless @people.include?(teacher)
    @teachers << teacher unless @teachers.include?(teacher)
  end

  def list_all_people
    if @people.empty?
      puts 'The list is empty, add some people...'
    else
      @people.each do |person|
        if person.instance_of?(Student)
          puts "[Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
        else
          puts "[Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
        end
      end
    end
  end

  def list_all_students
    @students.empty? ? 'The list is empty, add some students...' : @students.each { |student| puts student.name }
  end

  def list_all_teachers
    @teachers.empty? ? 'The list is empty, add some teachers...' : @teachers.each { |teacher| puts teacher.name }
  end
end
