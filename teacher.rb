require_relative 'person'

class Teacher < Person
  def initialize(age, name = 'Unknown')
    super(id, age, name)
  end

  def can_use_services?
    true
  end
end
