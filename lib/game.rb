require_relative 'board'
require 'colorize'
class Game

  def initialize(rows, cols, mines)
    @board = Board.new(rows,cols,mines)
  end

  def start_game

    while(!@victory)
      @board.render
      puts "ENTER INPUT IN THE FOLLOWING FORMAT:\n"
      print "row column f ".colorize(:green)
      print "OR "
      print "row column\n".colorize(:green)
      puts "Put f to flag space instead of opening."
      inputs = gets.chomp.split(' ')

      if inputs[2] != "F" && inputs[2] != "f"
        if !@board.open_cell(inputs[0].to_i, inputs[1].to_i)
          @board.render
          puts "GAME OVER!!"
          return
        end
      else
        @board.flag_cell(inputs[0].to_i, inputs[1].to_i)
      end
      if @board.win?
         @board.show_all
        break
      end
    end
    @board.render
  end

end

game = Game.new(5,5,3)
game.start_game
