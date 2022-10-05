require_relative 'nameable'
require_relative 'rental'

class Person < Nameable
  attr_accessor :name, :age, :id, :rentals
  def initialize(age, name, parent_permission: true)
    super()
    @id = Random.rand(1..100)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rentals = []
  end

  # def add_rental(rental)
  #   @rentals.push(rental)
  #   rental.person = self
  # end

  def add_rental(date, book)
    @rentals << Rental.new(date, self, book)
  end

  def correct_name
    @name
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def of_age?
    @age >= 18
  end
end
