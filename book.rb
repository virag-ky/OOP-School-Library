require_relative 'rental'

class Book
  attr_accessor :title, :author
  attr_reader :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(date, person)
    #@rentals.push(rental)
    #rental.book = self
    @rentals << Rental.new(date, self, person)
  end
end
