require_relative 'person'

class Student < Person
  def initialize(id, age, name = 'Unknown', classroom = 5)
    super(id, name, age, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end
