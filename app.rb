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

  def create_book
    puts 'Enter the title of the book:'
    title = gets.chomp
    puts 'Enter the author of the book:'
    author = gets.chomp
    book = Book.new(title, author)
    puts "The book \'#{title}\' by #{author} is created successfully!"
    @book_list << book unless @book_list.include?(book)
  end

  def create_rental
    puts "Select a book from the following list by number:\n"
    list_all_books
    index_of_book = gets.chomp.to_i
    puts "Select a person from the following list by number:\n"
    list_all_people
    index_of_person = gets.chomp.to_i
    puts 'Enter a date: e.g 2022/09/28'
    date = gets.chomp.to_i
    create_rental(date, book_list[index_of_book], people[index_of_person])
    rental = Rental.new(date, person, book)
    puts 'Rental successfully created!'
    @rentals << rental unless @rentals.include?(rental)
  end

  def list_all_rentals
    puts "Rentals list:\n\n"
    if @rentals.empty?
      'The list is empty, add some rentals...'
    else
      @rentals.each_with_index do |rental, index|
        puts "#{index}) Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}"
      end
    end
  end

  def list_all_books
    puts "Books list:\n\n"
    if @book_list.empty?
      'The list is empty, add some books...'
    else
      @book_list.each_with_index do |book, index|
        puts "#{index}) Title: '#{book.title}', Author: #{book.author}"
      end
    end
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

  def create_person
    puts 'Which do you want to create? A student (press 1) or a teacher (press 2)?'
    num = gets.chomp.to_i
    case num
    when 1
      student_option
    when 2
      teacher_option
    end
  end

  def student_option
    puts 'Enter the age of the student:'
    age = gets.chomp.to_i
    puts "Enter the student's classroom (number):"
    classroom = gets.chomp.to_i
    puts "Enter the student's name:"
    name = gets.chomp
    create_student(age, classroom, name)
    puts "The student named '#{name}' of age #{age} with the classroom number #{classroom} was created successfully!"
  end

  def teacher_option
    puts 'Enter the age of the teacher:'
    age = gets.chomp.to_i
    puts "Enter the teacher's specialization:"
    specialization = gets.chomp
    puts "Enter the teacher's name:"
    name = gets.chomp
    create_teacher(age, specialization, name)
    puts "The teacher named '#{name}' of age #{age} with the specialization #{specialization} was created successfully!"
  end

  def list_all_people
    puts "People's list:\n\n"
    if @people.empty?
      puts 'The list is empty, add some people...'
    else
      @people.each_with_index do |person, index|
        if person.instance_of?(Student)
          puts "#{index}) [Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
        else
          puts "#{index}) [Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
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
