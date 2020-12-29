
require 'pry'
class TicTacToe
   
  WIN_COMBINATIONS = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [6,4,2]
  ]

  def initialize(board=nil)
      @board = board || Array.new(9," ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
end

def input_to_index(player_input)
player_input = player_input.to_i
index = player_input-1
return index
end

def move (index, player = "X")
  @board[index.to_i] = player
end

def position_taken? (index)
@board[index] == "X" || @board[index] == "O"        
end

def valid_move?(index)       
index.between?(0,8) && !position_taken?(index)       
end
def turn_count        
  counter = 0
  @board.each do |space|
    if space == "X" || space == "O"
      counter += 1
    end
  end
  return counter
end

def current_player
  turn_count % 2 == 0 ? "X" : "O"
end

def turn
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(index)
    move(index, current_player)
    display_board
  else
    turn
  end

end




def won?
  board_empty = @board.none? { |i| i == "X" || i = "O"}
if board_empty
false
else 
WIN_COMBINATIONS.each do |combo| 
  if (@board[combo[0]] == "X" && @board[combo[1]] == "X" && 
     @board[combo[2]] == "X" || @board[combo[0]] == "O" && 
     @board[combo[1]] == "O" && @board[combo[2]] == "O")
    return combo
  end
end
return false
end
end

def full?
  @board.all? { |i| i =="X" || i == "O"}
end

def draw?
  !won? && full? ? true : false
end

def over?
  won? || draw? || full? ? true : false
end

def winner
  WIN_COMBINATIONS.detect do |combo| 
      if @board[combo[0]] == "X" && @board[combo[1]] == "X" && @board[combo[2]] == "X" 
        return "X"
      elsif @board[combo[0]] == "O" && @board[combo[1]] == "O" && @board[combo[2]] == "O"
        return "O"            
      else 
        nil
      end
  end
end

def play
  while !over?
    turn
  end      
  if won? 
    puts "Congratulations #{winner}!"
  elsif draw?
    puts "Cat's Game!"
  end       
end




end