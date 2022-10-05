require 'json'

module SaveRentalsData
  def save_rentals(rentals)
    rentals_list = []
    rentals_file = './rentals.json'

    return unless File.exist?(rentals_file)

    rentals.each do |rental|
      rentals_list << { date: rental.date, person: rental.person, book: rental.book }
    end
    File.write(rentals_file, JSON.generate(rentals_list))
  end

  def load_rentals
    rentals_list = []
    rentals_file = './rentals.json'

    return rentals_list unless File.exist?(rentals_file) && File.read(rentals_file) != ''

    JSON.parse(File.read(rentals_file)).each do |rental|
      rentals_list << Rental.new(rental['date'], rental['person'], rental['book'])
    end
    rentals_list
  end
end
