require_relative "person"

class Teacher < Person
  def initialize(specialization = "Math", id, name = "Unknown", age)
    super(id, age, name)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
