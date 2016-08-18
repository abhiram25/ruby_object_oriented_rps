require 'pry'

# Approach to OOP

# 1. Write a textual description of the problem or exercises
# 2. Extract major nouns and verbs
# 3. Organize and associate verbs with nouns
# 4. Nouns are the classes and the verbs are the behaviors or methods

# Rock, Paper, Scissors is a two-player game where each player
# chooses one of three possible moves: rock, paper, or scissors.
# The chosen moves will then be compared to see who wins, according
# to the following rules:

# - rock beats scissors
# - scissors beats paper
# - paper beats rock

# If the players chose the same move, then it's a tie.

# a = ['white snow', 'winter wonderland', 'melting ice',
#      'slippery sidewalk', 'salted roads', 'white trees']

# p a.map!{ |element| element.split}.flatten

class Person
  attr_accessor :name

  def name=(name)
  	@full_name = name
  	@first_name = @name.split.first
  	@last_name = @name.split.last
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name