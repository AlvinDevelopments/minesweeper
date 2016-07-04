require_relative 'cell'

class Board



  def initialize(rows, cols, mines)
    @rand = (0..8).to_a
    @board = Array.new(rows){Array.new(cols)}

    # assigns each box of the board with a mineless, unopened cell
    @board.each do |x|
      x.each_with_index { |y, i| x[i] = Cell.new(false)}
    end

    # assigns user-defined number of mines to random board coordinates
    mines.times do
      row = @rand.sample
      col = @rand.sample
      while(@board[row][col].mine?)
        row = @rand.sample
        col = @rand.sample
      end
      @board[row][col].mine = true
    end

    # assign numeric value representing mine count around cell
    @board.each_with_index do |x, i|
      x.each_with_index do |y, j|
        count = 0
        count +=1 if i < 9 && j < 9 && @board[i][j].mine? && i >= 0 && j >= 0
        count +=1 if i-1 < 9 && j < 9 && @board[i-1][j].mine? && i-1 >= 0 && j >= 0
        count +=1 if i-1 < 9 && j-1 < 9 && @board[i-1][j-1].mine? && i-1 >= 0 && j-1 >= 0
        count +=1 if i < 9 && j-1 < 9 && @board[i][j-1].mine? && i >= 0 && j-1 >= 0
        count +=1 if i+1 < 9 && j-1 < 9 && @board[i+1][j-1].mine? && i+1 >= 0 && j-1 >= 0
        count +=1 if i+1 < 9 && j < 9 && @board[i+1][j].mine? && i+1 >= 0 && j >= 0
        count +=1 if i+1 < 9 && j+1 < 9 && @board[i+1][j+1].mine? && i+1 >= 0 && j+1 >= 0
        count +=1 if i < 9 && j+1 < 9 && @board[i][j+1].mine? && i >= 0 && j+1 >=  0
        count +=1 if i-1 < 9 && j+1 < 9 && @board[i-1][j+1].mine? && i-1 >= 0 && j+1 >= 0
        @board[i][j].number = count if count != 0
      end
    end

  end

  def render
    puts "\n----------------------------"
    @board.each do |x|
      x.each { |y| print "| #{y.to_s}"}
      print "|"
      puts "\n----------------------------"
    end

  end


end

board = Board.new(9,9,10)
board.render
