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
    @book_list << Book.new(title, author)
    puts "The book \'#{title}\' by #{author} is created successfully!"
    books = []
    @book_list.each do |book|
      books << {title: book.title, author: book.author}
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
    date = gets.chomp.to_i
    rental = Rental.new(date, @people[index_of_person], @book_list[index_of_book])
    puts 'Rental successfully created!'
    @rentals << rental unless @rentals.include?(rental)
  end

  def list_rentals_by_id
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
    file = 'books.json'
    books_data = []
    puts "Books list:\n\n"
  
    if File.exist?(file) && File.read(file) != '' 
      JSON.parse(File.read(file)).each do |book| 
         books_data << "Title: #{book['title']}, Author: #{book['author']} "
      end
    else
      puts "List is empty, please add some books..."
    end
    puts books_data
  end

  def create_student(age, classroom, name, parent_permission)
    @students << Student.new(age, classroom, name, parent_permission: parent_permission)
    student = []
    @students.each do |std|
      student << { id: std.id, name: std.name, age: std.age, classroom: std.classroom }
    end
    File.write('students.json', student.to_json)
  end

  def create_teacher(age, specialization, name)
    @teachers << Teacher.new(age, specialization, name)
    teacher = []
    @teachers.each do |tch|
      teacher << { id: tch.id, age: tch.age, name: tch.name }
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

  # def list_all_people
  #   puts "People's list:\n\n"
  #   if @people.empty?
  #     puts 'The list is empty, add some people...'
  #   else
  #     @people.each_with_index do |person, index|
  #       if person.instance_of?(Student)
  #         puts "#{index}) [Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
  #       else
  #         puts "#{index}) [Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
  #       end
  #     end
  #   end
  # end

  def list_all_people
    list_all_students
    list_all_teachers
  end

  def list_all_students
    filename = 'students.json'
    studentsdata = []
    if File.exist?(filename) && File.read(filename) != ''
      JSON.parse(File.read(filename)).each do |student|
        studentsdata.push("ID: #{student['id']}, Name:  #{student['name']}, Age:  #{student['age']}")
      end
    end
    puts studentsdata
  end

  def list_all_teachers
    filename = 'teachers.json'
    teachersdata = []
    if File.exist?(filename) && File.read(filename) != ''
      JSON.parse(File.read(filename)).each do |teacher|
        teachersdata.push("ID: #{teacher['id']}, Name:  #{teacher['name']}, Age:  #{teacher['age']}")
      end
    end
    puts teachersdata
  end
end
