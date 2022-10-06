require './decorators'
require './person'

describe BaseDecorator do
  context "When using the correct_name method from the BaseDecorator class" do
    it "should return the correct name" do
      person = Person.new(30, "annabelleee")
      expect(person.correct_name).to eql "annabelleee"
    end
  end
end

describe CapitalizeDecorator do
  context "When using the correct_name method from the CapitalizeDecorator class" do
    it "should return the name in capitalized" do
      person = Person.new(30, "annabelleee")
      capitalized_name = CapitalizeDecorator.new(person)
      expect(capitalized_name.correct_name).to eql "Annabelleee"
    end
  end
end

describe TrimmerDecorator do
  context "When using the correct_name method from the TrimmerDecorator class" do
    it "should trim the name if it is longer than 10 characters" do
      person = Person.new(30, "annabelleee")
      trimmed_name = TrimmerDecorator.new(person)
      expect(trimmed_name.correct_name).to eql "annabellee"
    end
  end
end