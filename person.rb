class Person
  def initialize(id, name = "Unknown", age, parent_permission = true)
    @id = id
    @name = name
    @age = age
  end

  attr_reader :id
  attr_accessor :name
  attr_accessor :age

  private

  def is_of_age?
    @age >= 18
  end

  def can_use_services
    is_of_age? || parent_permission 
  end
end
