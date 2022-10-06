require './person'

describe Person do
  context "When creating a new Person class" do

    it "should be an instance of the Person class" do
      person = Person.new(23, "Maisy")
      expect(person).to be_instance_of Person
    end

    it "should have the following properties(age, name, id, parent_permission)" do
      person = Person.new(23, "Maisy")
      expect(person.age).to be 23
      expect(person.age).to be_kind_of Numeric
      expect(person.name).to eql "Maisy"
      expect(person.id).to be_kind_of Numeric
      expect(person.parent_permission).to be true
    end
  end

  context "When using the can_use_services? method" do

    it "should return true if the age of the person is greater than or equal than 18" do
      person = Person.new(23, "Maisy")
      expect(person.can_use_services?).to be true
    end

    it "should return true if the age of the person is less than 18 but has parent permission" do
      person = Person.new(14, "Maisy")
      expect(person.can_use_services?).to be true
    end

    it "should return false if the age of the person is less than 18 and has no parent permission" do
      person = Person.new(14, "Maisy")
      person.parent_permission = false
      expect(person.age).to be 14
      expect(person.can_use_services?).to be false
    end
  end
end