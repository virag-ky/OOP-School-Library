require 'json'

module SavePeoplesData
  def save_people(people)
    teachers_list = []
    students_list = []
    teachers_file = './teachers.json'
    students_file = './students.json'

    return unless File.exist?(teachers_file) && File.exist?(students_file)

    people.each do |person|
      case person
      when Student
        students_list << { id: person.id, age: person.age, classroom: person.classroom, name: person.name }
      when Teacher
        teachers_list << { id: person.id, age: person.age, name: person.name}
      end
    end
    File.write(students_file, JSON.generate(students_list))
    File.write(teachers_file, JSON.generate(teachers_list))
  end

  def load_people
    people_list = []
    teachers_file = './teachers.json'
    students_file = './students.json'

    unless File.exist?(teachers_file) && File.exist?(students_file) &&
           File.read(students_file) != '' && File.read(teachers_file) != ''
      return people_list
    end

    JSON.parse(File.read(students_file)).each do |student|
      people_list << Student.new(student['id'], student['age'], student['classroom'], student['name'],
                                 parent_permission: student['parent_permission'])
    end

    JSON.parse(File.read(teachers_file)).each do |teacher|
      people_list << Teacher.new(teacher['id'], teacher['age'], teacher['name'])
    end
    people_list
  end
end
