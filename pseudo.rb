class Student
  @@number_of_students = 0

  def initialize(name, course)
    @@number_of_students += 1
    @name = name
    @course = course
  end

  def self.number_of_students
    @@number_of_students
  end
end

puts Student.number_of_students   # => 0

dog1 = Student.new("Jason", 100)
dog2 = Student.new("Abhi", 100)

puts Student.number_of_students    # => 2