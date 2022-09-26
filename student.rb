require_relative "person"

class Student < Person
  def initialize(classroom = 5, id, name = "Unknown", age, parent_permission = true)
    super(id, name, age, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end