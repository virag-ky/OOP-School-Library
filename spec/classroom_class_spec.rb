require './classroom'

describe Classroom do
  context 'When creating a new Classroom class' do
    it 'should have a label property' do
      classroom = Classroom.new(5)
      expect(classroom.label).to eq 5
    end
    it 'the label should be an integer, a numeric value' do
      classroom = Classroom.new(5)
      expect(classroom.label).to be_kind_of Numeric
    end
    it 'should be an instance of the Classroom class' do
      classroom = Classroom.new(5)
      expect(classroom).to be_instance_of Classroom
    end
  end
end
