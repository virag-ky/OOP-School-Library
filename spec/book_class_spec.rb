require './book'

describe Book do
  context 'When creating a new Book class' do
    it 'should have the following properties(title, author)' do
      book = Book.new('Awesome Book', 'Micronaut')
      expect(book.title).to eql 'Awesome Book'
      expect(book.author).to eql 'Micronaut'
    end
    it 'should be an instance of the Book class' do
      book = Book.new('Awesome Book', 'Micronaut')
      expect(book).to be_instance_of Book
    end
  end
end
