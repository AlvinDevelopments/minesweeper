require_relative 'board'

class Game

  def initialize
    @board = Board.new(9,9,10)
  end

  def start_game

    while(!@victory)
      @board.render
      puts "ENTER INPUT IN THE FOLLOWING FORMAT: --R C F-- USE  F in the end for flag "
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
    if win?
      break
    end

    end
    @board.render
    puts "u win bitch"
  end

end

game = Game.new
game.start_game
