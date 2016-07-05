require_relative 'cell'

class Board



  def initialize(rows, cols, mines)
    @victory = false
    @rand_row = (0..rows-1).to_a
    @rand_col = (0..cols-1).to_a
    @board = Array.new(rows){Array.new(cols)}
    @rows = rows
    @cols = cols
    @mine_count = mines
    @first_move_flag = true
    @flag_count = mines

    # assigns each box of the board with a mineless, unopened cell
    @board.each do |x|
      x.each_with_index { |y, i| x[i] = Cell.new(false)}
    end

    # assigns user-defined number of mines to random board coordinates
    mines.times do
      row = @rand_row.sample
      col = @rand_col.sample
      while(@board[row][col].mine?)
        row = @rand_row.sample
        col = @rand_col.sample
      end
      @board[row][col].mine = true
    end

    count_mines

  end

  def count_mines
    @board.each_with_index do |x, i|
      x.each_with_index do |y, j|
        count = 0
        count +=1 if i < @rows && j < @cols && @board[i][j].mine? && i >= 0 && j >= 0
        count +=1 if i-1 < @rows && j < @cols && @board[i-1][j].mine? && i-1 >= 0 && j >= 0
        count +=1 if i-1 < @rows && j-1 < @cols && @board[i-1][j-1].mine? && i-1 >= 0 && j-1 >= 0
        count +=1 if i < @rows && j-1 < @cols && @board[i][j-1].mine? && i >= 0 && j-1 >= 0
        count +=1 if i+1 < @rows && j-1 < @cols && @board[i+1][j-1].mine? && i+1 >= 0 && j-1 >= 0
        count +=1 if i+1 < @rows && j < @cols && @board[i+1][j].mine? && i+1 >= 0 && j >= 0
        count +=1 if i+1 < @rows && j+1 < @cols && @board[i+1][j+1].mine? && i+1 >= 0 && j+1 >= 0
        count +=1 if i < @rows && j+1 < @cols && @board[i][j+1].mine? && i >= 0 && j+1 >=  0
        count +=1 if i-1 < @rows && j+1 < @cols && @board[i-1][j+1].mine? && i-1 >= 0 && j+1 >= 0
        @board[i][j].number = count if count != 0
      end
     end
  end

  def render
    puts "\n          MINESWEEPER   Flags: #{@flag_count}"
    puts "  -------------------------------------"
    print "  "
    @board.each_with_index { |y, i| print "| #{i} ".colorize(:blue)}
    puts "|\n  -------------------------------------"
    puts "  -------------------------------------"
    @board.each_with_index do |x, i|
      print "#{i}|".colorize(:blue)
      x.each { |y| print "| #{y.to_s} "}
      print "|"
      print "|#{i} ".colorize(:blue)
      puts "\n  -------------------------------------"
    end
    puts "  -------------------------------------"
    print "  "
    @board.each_with_index { |y, i| print "| #{i} ".colorize(:blue)}
    puts "|\n"
    puts "  -------------------------------------\n "

  end

  def open_cell(row, col)
    if row >= @rows || row < 0 || col >= @cols  || col < 0
      puts "invalid input, please try again"
    end

    if(@board[row][col].opened?)
      puts "already opened"
    end

   if @board[row][col].mine? && @first_move_flag
     row_temp = @rand_row.sample
     col_temp = @rand_col.sample

     while(@board[row_temp][col_temp].number!=0)
       row_temp = @rand_row.sample
       col_temp = @rand_col.sample
     end

     @board[row_temp][col_temp].mine = true
     @board[row][col].mine = false

    count_mines

     @first_move_flag = false
   end

    if(@board[row][col].mine?)
      @board.each_with_index do |x, i|
        x.each.with_index do |y, j|
          @board[i][j].open if @board[i][j].mine?
        end
      end
      return false
    end

   clear_cells(row,col)
   @first_move_flag = false
   return true
  end

  def flag_cell(row, col)
    flagging = @board[row][col].flag
    if  flagging && !@board[row][col].opened?
      @flag_count-=1
    elsif !flagging && !@board[row][col].opened?
       @flag_count+=1
    end
  end


  def clear_cells(i,j)
    if @board[i][j].opened? || @board[i][j].flag?
      return
    end

    @board[i][j].open

    return if i < @rows && j < @cols && @board[i][j].mine? && i >= 0 && j >= 0
    return if i-1 < @rows && j < @cols && @board[i-1][j].mine? && i-1 >= 0 && j >= 0
    return if i-1 < @rows && j-1 < @cols && @board[i-1][j-1].mine? && i-1 >= 0 && j-1 >= 0
    return if i < @rows && j-1 < @cols && @board[i][j-1].mine? && i >= 0 && j-1 >= 0
    return if i+1 < @rows && j-1 < @cols && @board[i+1][j-1].mine? && i+1 >= 0 && j-1 >= 0
    return if i+1 < @rows && j < @cols && @board[i+1][j].mine? && i+1 >= 0 && j >= 0
    return if i+1 < @rows && j+1 < @cols && @board[i+1][j+1].mine? && i+1 >= 0 && j+1 >= 0
    return if i < @rows && j+1 < @cols && @board[i][j+1].mine? && i >= 0 && j+1 >=  0
    return if i-1 < @rows && j+1 < @cols && @board[i-1][j+1].mine? && i-1 >= 0 && j+1 >= 0

    if i-1 < @rows && j < @cols && @board[i-1][j].number == 0 && i-1 >= 0 && j >= 0
      clear_cells(i-1,j)
    elsif i-1 < @rows && j < @cols && @board[i-1][j].number != 0 && i-1 >= 0 && j >= 0
      @board[i-1][j].open
    end
    if i-1 < @rows && j-1 < @cols && @board[i-1][j-1].number == 0 && i-1 >= 0 && j-1 >= 0
      clear_cells(i-1,j-1)
    elsif i-1 < @rows && j-1 < @cols && @board[i-1][j-1].number != 0 && i-1 >= 0 && j-1 >= 0
      @board[i-1][j-1].open
    end
    if i < @rows && j-1 < @cols && @board[i][j-1].number == 0 && i >= 0 && j-1 >= 0
      clear_cells(i,j-1)
    elsif i < @rows && j-1 < @cols && @board[i][j-1].number != 0 && i >= 0 && j-1 >= 0
      @board[i][j-1].open
    end
    if i+1 < @rows && j-1 < @cols && @board[i+1][j-1].number == 0 && i+1 >= 0 && j-1 >= 0
      clear_cells(i,j)
    elsif i+1 < @rows && j-1 < @cols && @board[i+1][j-1].number != 0 && i+1 >= 0 && j-1 >= 0
      @board[i+1][j-1].open
    end
    if i+1 < @rows && j < @cols && @board[i+1][j].number == 0 && i+1 >= 0 && j >= 0
      clear_cells(i+1,j)
    elsif i+1 < @rows && j < @cols && @board[i+1][j].number != 0 && i+1 >= 0 && j >= 0
      @board[i+1][j].open
    end
    if i+1 < @rows && j+1 < @cols && @board[i+1][j+1].number == 0 && i+1 >= 0 && j+1 >= 0
      clear_cells(i+1,j+1)
    elsif i+1 < @rows && j+1 < @cols && @board[i+1][j+1].number != 0 && i+1 >= 0 && j+1 >= 0
      @board[i+1][j+1].open
    end
    if i < @rows && j+1 < @cols && @board[i][j+1].number == 0 && i >= 0 && j+1 >=  0
      clear_cells(i,j+1)
    elsif i < @rows && j+1 < @cols && @board[i][j+1].number != 0 && i >= 0 && j+1 >=  0
      @board[i][j+1].open
    end
    if i-1 < @rows && j+1 < @cols && @board[i-1][j+1].number == 0 && i-1 >= 0 && j+1 >= 0
      clear_cells(i-1,j+1)
    elsif i-1 < @rows && j+1 < @cols && @board[i-1][j+1].number != 0 && i-1 >= 0 && j+1 >= 0
      @board[i-1][j+1].open
    end
  end


   def win?
     @board.each do |x|
       x.each do |y|
         if y.mine? && !y.opened? && !y.flag?
           return false
         end
         if !y.mine? && !y.opened? && y.flag?
           return false
         end
         if !y.mine? && !y.opened?
           return false
         end
       end
     end
    puts "YOU WIN!!!"
     return true
   end

  def show_all
    @board.each do |x|
      x.each do |y|
        y.visibility = true
      end
    end

  end


  def show_all
   @board.each do |x|
     x.each do |y|
      y.visibility = true
     end
   end
  end

end
