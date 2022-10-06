require_relative '../student'
require_relative '../classroom'

describe Student do
  before :each do
    @student = Student.new(13, 5, 'Mark Jacob', parent_permission: false)
  end

  context 'when student class object is created' do
    it 'should return correct values' do
      expect(@student.age).to eq(13)
      expect(@student.name).to eq('Mark Jacob')
      expect(@student.can_use_services?).to be false
    end
  end

  context 'when new classroom is created' do
    it 'should show the new classroom number' do
      classroom = Classroom.new('45')
      @student = Student.new(23, classroom, 'Kevin Spacey', parent_permission: true)
      expect(@student.classroom).to eq(classroom)
    end
  end
end
