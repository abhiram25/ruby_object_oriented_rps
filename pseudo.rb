require 'pry'

# Write a method that takes one argument, a positive integer,
# and returns the sum of its digits.

# Given the integer, split the integer into individual digits
# Convert the integer into a string and save it to a variable
# called splitted integer.

# iterate through the splitted_integer array and
# convert each character into a number

def sum(integer)
	integer.to_s.chars.map {|num| num.to_i}.inject(:+)
end

puts sum(23) == 5
puts sum(496) == 19
puts sum(123_456_789) == 45