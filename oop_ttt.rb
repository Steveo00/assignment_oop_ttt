class Board
  attr_accessor :b
  def initialize(b)
    system 'clear'
    puts "\n"
    puts "     |     |"
    puts "  " + b[1] + "  |  " + b[2] + "  |  " + b[3]
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  " + b[4] + "  |  " + b[5] + "  |  " + b[6]
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  " + b[7] + "  |  " + b[8] + "  |  " + b[9]
    puts "     |     |"    
  end
end

class Player
  attr_reader :name
  def initialize(name)
    @name = name
  end
  def to_s
    "Players name is #{name}"
  end
end

class Human < Player
  attr_reader :name
  def pick_move
    puts "OK #{name}, please enter a number from 1..9"
    gets.chomp.to_i
  end
end

class Computer < Player
  def pick_move(b)
     selection = b.select{|k,v| v == ' ' }.keys.sample
  end
end

class Game
  attr_accessor :board, :b, :player, :computer
  def initialize
    puts "Welcome to Tic Tac Toe"
    puts "\n"
    puts "Please enter your name:"
    player_name = gets.chomp
    puts "Please enter what you would like to call the computer:"
    computer_name = gets.chomp
    @b ={}
    (1..9).each{ |position| @b[position] = " " }
    @board = Board.new(@b)
    @player = Human.new(player_name)
    @computer = Computer.new(computer_name)
  end

  def check_winner(b)
    winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7],[2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    winning_lines.each do |line|
    return "Player" if b.values_at(*line).count("X") == 3
    return "Computer" if b.values_at(*line).count("O") == 3
    nil
   end
  end

  def play
    begin
      @b[@player.pick_move] = "X"
      @b[@computer.pick_move(@b)] = "O"
      @board = Board.new(@b)
      begin
        if check_winner(b) == "Player" || check_winner(b) == "Computer"
          begin
            if check_winner(b) == "Player" then puts "#{player.name} won"
            elsif check_winner(b) == "Computer" then puts "#{computer.name} won"
            end  
            puts "Do you want to play again: (y/n)?"
            continue = gets.chomp.downcase
            if continue != "y"
              begin
                puts "Goodbye #{player.name}"
                exit
              end
            else
              begin         
               @b ={}
               (1..9).each{ |position| @b[position] = " " }                 
               @board = Board.new(@b)
               end    
            end  
          end
        end    
      end
    end while @b.has_value?(" ")  
  end
end

game = Game.new.play