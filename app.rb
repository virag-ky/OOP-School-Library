require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'save_books'
require_relative 'save_people'
require_relative 'save_rentals'

class App
  def initialize
    @book_list = load_books
    @people = load_people
    @students = []
    @teachers = []
    @rentals = load_rentals
  end

  include SaveBooksData
  include SavePeoplesData
  include SaveRentalsData

  def save_data
    save_books(@book_list)
    save_people(@people)
    save_rentals(@rentals)
  end

  def create_book
    puts 'Enter the title of the book:'
    title = gets.chomp
    puts 'Enter the author of the book:'
    author = gets.chomp
    @book_list << Book.new(title, author)
    puts "The book \'#{title}\' by #{author} is created successfully!"
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
    book = "#{@book_list[index_of_book].title} by #{@book_list[index_of_book].author}"
    rental = Rental.new(date, @people[index_of_person].id, book)
    puts 'Rental successfully created!'
    @rentals << rental unless @rentals.include?(rental)
  end

  def list_rentals_by_id
    print "Enter a person's ID: "
    person_id = gets.chomp.to_i
    rentals_by_id = @rentals.select { |rental| rental.person == person_id }
    puts "Rentals list:\n\n"
    if rentals_by_id.empty?
      puts 'The list is empty, add some rentals...'
    else
      rentals_by_id.each do |rental|
          
          puts "Date: #{rental.date}, Book: #{rental.book}"
        end
      end
    end


  def list_all_books
    puts "Books list:\n\n"
    if @book_list.empty?
      puts 'The list is empty, add some books...'
    else
      @book_list.each_with_index do |book, index|
        puts "#{index}) Title: '#{book.title}', Author: #{book.author}"
      end
    end
  end

  def create_student(age, classroom, name, parent_permission)
    student = Student.new(age, classroom, name, parent_permission: parent_permission)
    @people << student unless @people.include?(student)
    @students << student unless @students.include?(student)
  end

  def create_teacher(age, name)
    teacher = Teacher.new(age, name)
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
    create_teacher(age, name)
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
    only_students = @people.select { |student| student.instance_of?(Student) }
    if only_students.empty?
      puts 'The list is empty, add some students...'
    else
      only_students.each do |student|
        puts "Name: #{student.name}, Classroom: #{student.classroom}, ID: #{student.id}, Age: #{student.age}"
      end
    end
  end

  def list_all_teachers
    only_teachers = @people.select { |teacher| teacher.instance_of?(Teacher) }
    if only_teachers.empty?
      puts 'The list is empty, add some teachers...'
    else
      only_teachers.each do |teacher|
        puts "Name: #{teacher.name}, ID: #{teacher.id}, Age: #{teacher.age}"
      end
    end
  end
end
