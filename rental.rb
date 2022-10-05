require_relative 'person'

class Rental
  attr_accessor :date, :person, :book, :rentals

  def initialize(date, person, book)
    @date = date
    
    @person = person
    #person.rentals << self
    #person.add_rental << self

    @book = book
    #book.rentals << self
  end
end
