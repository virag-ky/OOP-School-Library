require_relative 'person'

class Rental
  attr_accessor :date, :person, :book, :rentals

  def initialize(date, person, book)
    @date = date
    @person = person
    @book = book
  end
end
