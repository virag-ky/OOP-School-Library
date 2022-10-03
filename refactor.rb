require_relative 'app'

class Select
  def select_method(option, app)
    case option
    when 1
      app.list_all_books
    when 2
      app.list_all_people
    when 3
      app.create_person
    when 4
      app.create_book
    when 5
      app.create_rental
    when 6
      app.list_rentals_by_id
    when 7
      exit
    end
  end
end
