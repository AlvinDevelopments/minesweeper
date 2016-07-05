require 'colorize'
class Cell

  attr_accessor :mine, :number, :visibility, :flag

  def initialize(mine)
    @mine = false
    @number = 0
    @visibility = false
    @flag = false
  end

  def to_s
    return "F" if flag? && !@visibility
    return " " if !opened?
    return @number if !@mine && @number != 0
    return "-" if !@mine && @number == 0
    return 'X'.colorize(:red)
  end

  def opened?
    return @visibility
  end

  def mine?
    return @mine
  end

  def open
    @visibility = true
    @flag = false
  end

  def flag
   if opened?
     puts "cannot flag opened cell"
     return false
   end
   if !@flag
     @flag = true
   elsif @flag
     @flag = false
   end
   return @flag
  end

  def flag?
    @flag
  end

end
