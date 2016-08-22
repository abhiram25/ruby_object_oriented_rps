class Move
  VALUES = ["rock", "paper", "scissors", "lizard", "spock"].freeze
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

  def scissors_loses(other_move)
    ((rock? || spock?) && other_move.scissors?)
  end

  def rock_loses(other_move)
    ((spock? || paper?) && other_move.rock?)
  end

  def lizard_loses(other_move)
    ((rock? || scissors?) && other_move.lizard?)
  end

  def spock_loses(other_move)
    ((lizard? || paper?) && other_move.spock?)
  end

  def paper_loses(other_move)
    ((scissors? || lizard?) && other_move.paper?)
  end

  def >(other_move)
    scissors_loses(other_move) ||
      rock_loses(other_move) ||
      lizard_loses(other_move) ||
      spock_loses(other_move) ||
      paper_loses(other_move)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name, :score, :move_history

  def initialize
    @losing_moves = []
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
    @move = Move.new(choice)
    @move_history << choice
  end
end

class Computer < Player
  attr_accessor :losing_moves

  def initialize
    super
    self.losing_moves = []
  end

  def set_name
    self.name = "Tom"
  end

  def best_options
    if !move_history.empty?
      Move::VALUES.select do |value|
        losing_moves.count(value).to_f / move_history.length < 0.4
      end
    else
      Move::VALUES
    end
  end

  def choose
    @move = Move.new(best_options.sample)
    @move_history << move.to_s
  end
end

class Bill < Computer
  VALUES = ["scissors", "scissors", "rock", "spock"].freeze

  def set_name
    self.name = "Bill"
  end

  def choose
    mv = VALUES.sample
    self.move = Move.new(mv)
  end
end

class Jason < Computer
  def set_name
    self.name = "Jason"
  end

  def choose
    self.move = Move.new("rock")
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = [Computer.new, Bill.new, Jason.new].sample
  end

  def display_welcome_message
    puts "Hi #{human.name}, Welcome to Rock, Paper, Scissors!"
  end

  def series_winner(human, computer)
    human.score == 10 || computer.score == 10
  end

  def detect_winner
    if human.move > computer.move
      human.name.to_s
    elsif computer.move > human.move
      computer.name.to_s
    else
      "it's a tie"
    end
  end

  def display_choices
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def winner(player)
    detect_winner == player.name.to_s
  end

  def update_score(human, computer)
    if winner(human)
      human.score += 1
      computer.losing_moves << computer.move.to_s
    elsif winner(computer)
      computer.score += 1
    end
  end

  def display_winner
    display_choices
    if winner(human)
      puts "#{human.name} won!"
    elsif winner(computer)
      puts "#{computer.name} won!"
    else
      puts "It's a tie"
    end
    display_score
    display_series_winner if series_winner(human, computer)
  end

  def display_score
    puts "#{human.name}: #{human.score} #{computer.name}: #{computer.score}"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good Bye!"
  end

  def display_series_winner
    if detect_winner == computer.name.to_s
      puts "#{computer.name} won the series"
    elsif detect_winner == human.name.to_s
      puts "#{human.name} won the series"
    end
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
    computer.score = 0
    human.score = 0
    computer.move_history = []
    computer.losing_moves = []
    human.move_history = []
  end

  def play
    display_welcome_message
    loop do
      new_game
      loop do
        human.choose
        computer.choose
        update_score(human, computer)
        display_winner
        break if series_winner(human, computer)
      end
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
