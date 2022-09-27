require_relative 'person'
require_relative 'decorators'
require_relative 'classroom'
require_relative 'student'

student = Student.new(12, 5, 'Maisy')
puts student.name
classroom = Classroom.new(5)
puts classroom.students
student2 = Student.new(8, 2, 'Marie')
classroom2 = Classroom.new(3)
classroom2.add_student(student2)
classroom2.students.each {|student| puts student.name}

