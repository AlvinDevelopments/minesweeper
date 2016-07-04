require_relative 'board'

class Game

  def initialize
    @board = Board.new(9,9,10)
  end

  def start_game

    while(!@victory)
      @board.render
      puts "Make yo move row!!!"
      row = gets.chomp
      puts "Make yo move row!!!"
      col = gets.chomp
      if !@board.open_cell(row.to_i, col.to_i)
        @board.render
        puts "GAME OVER!!"
        return
      end

    end
    @board.render
    puts "u win bitch"
  end

end

game = Game.new
game.start_game
