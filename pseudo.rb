# Create a class for each robot
# Each robot will have a different choose method

# Class Tom
# Tom plays like the computer

class Tom < Computer
	attr_reader :name
	def initialize
		@name = "Tom"
	end
end

# Class Bill
# Bill mostly chooses scissors, rarely chooses rock
# Never paper

# Class Jason
# Jason only chooses rock