class Cell

  attr_accessor :mine, :number, :visibility

  def initialize(mine)
    @mine = false
    @number = 0
    @visibility = true
  end

  def to_s
    return "O" if !opened?
    return @number if !@mine && @number != 0
    return " " if !@mine && @number == 0
    return 'X'
  end

  def opened?
    return @visibility
  end

  def mine?
    return @mine
  end


end
