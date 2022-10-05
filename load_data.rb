require 'json'

module LoadData
  def load_all_books
    file = 'books.json'
    books = []
    if File.exist?(file) && File.read(file) != ''
      books = JSON.parse(File.read(file)).map { |book| Book.new(book['title'], book['author']) }
    end
    books
  end

  def load_all_students
    file = 'students.json'
    students = []
    if File.exist?(file) && File.read(file) != ''
      students = JSON.parse(File.read(file)).map do |student|
        Student.new(student['age'], student['classroom'], student['name'], student['id'])
      end
    end
    students
  end

  def load_all_teachers
    file = 'teachers.json'
    teachers = []
    if File.exist?(file) && File.read(file) != ''
      teachers = JSON.parse(File.read(file)).map do |teacher|
        Teacher.new(teacher['age'], teacher['specialization'], teacher['name'], teacher['id'])
      end
    end
    teachers
  end

  def load_all_rentals
    file = 'rentals.json'
    rentals = []
    if File.exist?(file) && File.read(file) != ''
      rentals = JSON.parse(File.read(file)).map do |rental|
        Rental.new(rental['date'],
                   Person.new(rental['person']['age'], rental['person']['name'], rental['person']['id']),
                   Book.new(rental['book']['title'], rental['book']['author']))
      end
    end
    rentals
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
end
