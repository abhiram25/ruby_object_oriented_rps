require 'pry'

class Move
  VALUES = ["rock", "paper", "scissors", "lizard"].freeze
  def initialize(value)
    @value = value
  end

  def scissors?
    @value == "scissors"
  end

  def rock?
    @value == "rock"
  end

  def paper?
    @value == "paper"
  end

  def lizard?
    @value == "lizard"
  end

  def spock?
    @value == "spock"
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
    (rock? && other_move.lizard?) ||
    (lizard? && other_move.spock?) ||
    (lizard? && other_move.paper?) ||
    (paper? && other_move.rock?) ||
    (paper? && other_move.spock?) ||
    (scissors? && other_move.paper?) ||
    (scissors? && other_move.lizard?) ||
    (spock? && other_move.rock?) ||
    (spock? && other_move.scissors?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    @score = 0
    set_name
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What is your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must provide a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry invalid choice"
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ["Tom", "Bill", "Jason"].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Hi #{human.name}, Welcome to Rock, Paper, Scissors!"
  end

  def detect_winner
    if human.move > computer.move
      human.score += 1
      "#{human.name} won!"
    elsif computer.move > human.move
      computer.score += 1
      "#{computer.name} won!"
    else
      "it's a tie"
    end
  end

  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    if series_winner(human, computer)
      puts detect_winner.to_s + "won the series"
    else
      puts detect_winner.to_s
    end
  end

  def series_winner(human, computer)
    human.score == 10 || computer.score == 10
  end

  def display_score
    puts "#{human.name}: #{human.score} #{computer.name}: #{computer.score}"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good Bye!"
  end

  def play_again?
    decision = nil
    loop do
      puts "Play again? (y/n)"
      decision = gets.chomp.downcase
      break if ["y", "n"].include?(decision)
      puts "Please type in 'y' for yes or 'n' for no"
    end
    decision == "y"
  end

  def new_game
    human.score = 0
    computer.score = 0
  end

  def play
    display_welcome_message
    loop do
      new_game
      loop do
        human.choose
        computer.choose
        display_winner
        display_score
        break if series_winner(human, computer)
      end
      display_goodbye_message
      break unless play_again?
    end
  end
end

# Instantiating RPSGame and calling play on it
RPSGame.new.play
