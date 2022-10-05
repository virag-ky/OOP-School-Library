require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'
require 'json'

class App
  def initialize
    @book_list = []
    @people = []
    @students = []
    @teachers = []
    @rentals = []
  end

  def create_book
    puts 'Enter the title of the book:'
    title = gets.chomp
    puts 'Enter the author of the book:'
    author = gets.chomp
    if @book_list.length == 0
      @book_list = get_all_books
    end
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
    @rentals = get_all_rentals
    @rentals << Rental.new(date, @people[index_of_person], @book_list[index_of_book])
    rental = []
    @rentals.each do |rent|
      rental << { date: rent.date, 
        person: {id: rent.person.id, name: rent.person.name, age: rent.person.age}, 
        book: {title: rent.book.title, author: rent.book.author} 
      }
    end
    File.write('rentals.json', rental.to_json)
    puts 'Rental successfully created!'
  end

  def list_rentals_by_id
    @rentals = get_all_rentals
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
    @book_list = get_all_books
    if @book_list.length == 0
      puts 'List is empty, please add some books...'
    else
      @book_list.each_with_index do |book, index|
        puts "#{index}) Title: #{book.title}, Author: #{book.author} "
      end
    end
  end

  def get_all_books
    file = 'books.json'
    books=[];
    if File.exist?(file) && File.read(file) != ''
      books = JSON.parse(File.read(file)).map { |book| Book.new(book['title'], book['author']) }
    end
    return books
  end

  def create_student(age, classroom, name, parent_permission)
    if @students.length == 0
      @students = get_all_students
    end
    @students << Student.new(age, classroom, name, parent_permission: parent_permission)
    student = []
    @students.each do |std|
      student << { id: std.id, name: std.name, age: std.age, classroom: std.classroom }
    end
    File.write('students.json', student.to_json)
  end

  def create_teacher(age, specialization, name)
    if @teachers.length == 0
      @teachers = get_all_teachers
    end
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

  def permission?(parent_permission)
    print 'Has parent permission? [Y/N]:'
    permission = gets.chomp

    case permission
    when 'n', 'N'
      !parent_permission
    when 'y', 'Y'
      parent_permission
    else
      permission?(parent_permission)
    end
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
    if @students.length == 0
      @students = get_all_students
    end
    if @teachers.length == 0
      @teachers = get_all_teachers
    end

    @people = @teachers | @students

    @people.each_with_index do |person, index|
      puts "#{index} ID: #{person.id}, Name:  #{person.name}, Age:  #{person.age}"
    end
  end

  def list_all_students
    @student = get_all_students

    if @student.length == 0
      puts 'Student List is empty. Please add students'
    else
      @student.each_with_index do |student, index|
        puts "ID: #{student.id}, Name:  #{student.name}, Age:  #{student.age}"
      end
    end
  end

  def list_all_teachers
    @teachers = get_all_teachers

    if @teachers.length == 0
      puts 'There are no teachers. Please add some teachers to the list...'
    else
      @teachers.each_with_index do |teacher, index|
        puts "ID: #{teacher.id}, Name:  #{teacher.name}, Age:  #{teacher.age}"
      end
    end
  end

  def get_all_students
    file = 'students.json'
    students=[];
    if File.exist?(file) && File.read(file) != ''
      students = JSON.parse(File.read(file)).map { 
        |student| Student.new(student['age'], student['classroom'], student['name'], student['id'] ) 
      }
    end
    return students
  end

  def get_all_teachers
    file = 'teachers.json'
    teachers=[];
    if File.exist?(file) && File.read(file) != ''
      teachers = JSON.parse(File.read(file)).map { 
        |teacher| Teacher.new(teacher['age'], teacher['specialization'], teacher['name'], teacher['id'] ) 
      }
    end
    return teachers
  end

  def get_all_rentals
    file = 'rentals.json'
    rentals=[];
    if File.exist?(file) && File.read(file) != ''
      rentals = JSON.parse(File.read(file)).map { 
        |rental| Rental.new(rental['date'],
          Person.new(rental['person']['age'],rental['person']['name'],rental['person']['id']),
          Book.new(rental['book']['title'], rental['book']['author'])
        ) 
      }
    end
    return rentals
  end
end
