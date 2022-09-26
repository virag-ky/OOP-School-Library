class Person
  def initialize(id, name, age, _parent_permission)
    @id = id
    @name = name
    @age = age
  end

  attr_reader :id
  attr_accessor :name, :age

  private

  def of_age?
    @age >= 18
  end

  def can_use_services?
    is_of_age? || parent_permission
  end
end
