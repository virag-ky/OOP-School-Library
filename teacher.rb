require_relative 'person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(age, specialization = 'Javascript', name = 'Unknown', id = -1, parent_permission: true)
    super(age, name, id, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
