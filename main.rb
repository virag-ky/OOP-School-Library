require_relative 'person'
require_relative 'decorators'
require_relative 'classroom'
require_relative 'student'
require_relative 'rental'
require_relative 'book'

student = Student.new(12, 5, 'Maisy')
puts student.name
classroom = Classroom.new(5)
puts classroom.students
student2 = Student.new(8, 2, 'Marie')
classroom2 = Classroom.new(3)
classroom2.add_student(student2)
classroom2.students.each { |x| puts x.name }

book = Book.new('Life is Good', 'Virag K.')
puts book.title
puts book.author

person = Person.new(40, 'Bob')
puts person.age
puts person.name

rental = Rental.new('2022-09-27', person, book)
puts rental.date
puts rental.person.name
puts rental.book.title

person.rentals.each { |item| puts item.book.title }

book2 = Book.new('Math Magicians', 'John Doe')
person2 = Person.new(22, 'John')
rental2 = Rental.new('2022-09-27', person, book2)
puts rental2.date
person.rentals.each { |item| puts item.book.title }

book.rentals.each { |item| puts item.person.name }

rental3 = Rental.new('2022-09-27', person2, book)
puts rental3.book.title
book.rentals.each { |item| puts item.person.name }
