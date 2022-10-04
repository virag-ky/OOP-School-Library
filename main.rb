#!/usr/bin/env ruby

require_relative 'refactor'
require 'json'


puts "Welcome to the School Library App!\n"

def main

  
  app = App.new
  loop do
    puts "
    Please choose an option by entering a number from below:\n
    1 - List all books
    2 - List all people
    3 - Create a person
    4 - Create a book
    5 - Create a rental
    6 - List all rentals for a given person (id)
    7 - List all students
    8 - List all teachers
    9 - Exit"

    option = gets.chomp.to_i
    select = Select.new
    select.menu(option, app)
    select.extra_options(option, app)
    exit unless option != 9
  end
end
main
