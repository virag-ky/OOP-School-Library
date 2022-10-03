require_relative 'app'

class Select
  def menu(option, app)
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
    end
  end

  def extra_options(option, app)
    case option
    when 7
      app.list_all_students
    when 8
      app.list_all_teachers
    end
  end
end
