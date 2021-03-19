require "pry"
class TicTacToe
    
    def initialize(board = nil)
      @board = board || Array.new(9, " ")
    end
    
    WIN_COMBINATIONS = [
        [0,1,2], # Top row
        [3,4,5],  # Middle row
        [6,7,8],
        [0,4,8],
        [2,4,6],
        [0,3,6],
        [1,4,7],
        [2,5,8]
      ]

     def input_to_index(input)
      input.to_i - 1 
     end

     def move(position, token = X)
      @board[position.to_i] = token
     end

    def position_taken?(position)
      if @board[position] == "X" || @board[position] == "O"
        true
      else
        false
      end
    end

    def valid_move?(input)
      if input.between?(0, 8) && !position_taken?(input)
          return true
      else
        return false
      end
    end
    
    def current_player
      turn_count.even? ? "X" : "O"
    end

    def turn
      puts "Please enter a number between 1 and 9"
      input = gets.strip
      number = input_to_index(input)
      if valid_move?(number)
        move(number, current_player)
        display_board
      else 
        turn
      end
    end

    def won?
      WIN_COMBINATIONS.each do |set|
        position_one = @board[set[0]]
        position_two = @board[set[1]]
        position_three = @board[set[2]]
        if position_one == "X" && position_two == "X" && position_three == "X" || position_one == "O" && position_two == "O" && position_three == "O"
          return set
        end
      end
      return false
    end

    def full?
      @board.all? do |position|
        if position == " "
          false
        else
          true
        end
      end
    end

    def draw?
      if !won? && full?
        true
      end
    end

    def over?
      if won? || draw?
        true
      end
    end

    def winner
      WIN_COMBINATIONS.each do |set|
        position_one = @board[set[0]]
        position_two = @board[set[1]]
        position_three = @board[set[2]]
        if position_one == "X" && position_two == "X" && position_three == "X"
          return "X"
        elsif position_one == "O" && position_two == "O" && position_three == "O"
          return "O"
        end
      end
      nil
    end

    def play
         until over?
          turn
         end
         if won?
          puts "Congratulations #{winner}!"
         else
          puts "Cat's Game!"
         end
    end
  
    def turn_count
      @board.count{|token| token == "X" || token == "O"}
    end
  
    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end
  end


