require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'load_data'
require 'json'

class App
  def initialize
    @book_list = []
    @people = []
    @students = []
    @teachers = []
    @rentals = []
  end

  include LoadData

  def create_book
    puts 'Enter the title of the book:'
    title = gets.chomp
    puts 'Enter the author of the book:'
    author = gets.chomp
    @book_list = load_all_books if @book_list.length.zero?
    @book_list << Book.new(title, author)
    puts "The book \'#{title}\' by #{author} is created successfully!"
    books = []
    @book_list.each do |book|
      books << { title: book.title, author: book.author }
    end
    File.write('books.json', books.to_json)
  end

  def create_rental
    puts "Select a book from the following list by number:\n"
    list_all_books
    index_of_book = gets.chomp.to_i
    puts "Select a person from the following list by number:\n"
    list_all_people
    index_of_person = gets.chomp.to_i
    puts 'Enter a date: e.g 2022/09/28'
    date = gets.chomp

    puts "Person Selected: #{@people[index_of_person].name}\n"
    puts "Book Selected: #{@book_list[index_of_book].title}\n"

    @rentals = load_all_rentals
    @rentals << Rental.new(date, @people[index_of_person], @book_list[index_of_book])

    rental = []
    @rentals.each do |rent|
      rental << { date: rent.date,
                  person: { id: rent.person.id, name: rent.person.name, age: rent.person.age },
                  book: { title: rent.book.title, author: rent.book.author } }
    end
    File.write('rentals.json', rental.to_json)
    puts 'Rental successfully created!'
  end

  def list_rentals_by_id
    @rentals = load_all_rentals
    print "Enter a person's ID: "
    person_id = gets.chomp.to_i
    puts "Rentals list:\n\n"
    if @rentals.empty?
      puts 'The list is empty, add some rentals...'
    else
      @rentals.select do |rental|
        if rental.person.id == person_id
          puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}"
        end
      end
    end
  end

  def list_all_books
    puts "Books list:\n\n"
    @book_list = load_all_books
    if @book_list.length.zero?
      puts 'List is empty, please add some books...'
    else
      @book_list.each_with_index do |book, index|
        puts "#{index}) Title: #{book.title}, Author: #{book.author} "
      end
    end
  end

  def create_student(age, classroom, name, parent_permission)
    @students = load_all_students if @students.length.zero?
    @students << Student.new(age, classroom, name, parent_permission: parent_permission)
    student = []
    @students.each do |std|
      student << { id: std.id, name: std.name, age: std.age, classroom: std.classroom }
    end
    File.write('students.json', student.to_json)
  end

  def create_teacher(age, specialization, name)
    @teachers = load_all_teachers if @teachers.length.zero?
    @teachers << Teacher.new(age, specialization, name)
    teacher = []
    @teachers.each do |tch|
      teacher << { id: tch.id, name: tch.name, age: tch.age, specialization: tch.specialization }
    end
    File.write('teachers.json', teacher.to_json)
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
    parent_permission = true
    permission?(parent_permission)
    create_student(age, classroom, name, parent_permission)
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
    @students = load_all_students if @students.length.zero?
    @teachers = load_all_teachers if @teachers.length.zero?

    @people = @teachers | @students

    @people.each_with_index do |person, index|
      puts "#{index} ID: #{person.id}, Name:  #{person.name}, Age:  #{person.age}"
    end
  end

  def list_all_students
    @student = load_all_students

    if @student.length.zero?
      puts 'Student List is empty. Please add students'
    else
      @student.each_with_index do |student, _index|
        puts "ID: #{student.id}, Name:  #{student.name}, Age:  #{student.age}"
      end
    end
  end

  def list_all_teachers
    @teachers = load_all_teachers

    if @teachers.length.zero?
      puts 'There are no teachers. Please add some teachers to the list...'
    else
      @teachers.each_with_index do |teacher, _index|
        puts "ID: #{teacher.id}, Name:  #{teacher.name}, Age:  #{teacher.age}"
      end
    end
  end
end
