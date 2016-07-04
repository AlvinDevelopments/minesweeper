class Cell

  attr_accessor :mine, :number, :visibility

  def initialize(mine)
    @mine = false
    @number = 0
    @visibility = false
  end

  def to_s
    return " " if !opened?
    return @number if !@mine #&& @number != 0
    # return " " if !@mine && @number == 0
    return 'X'
  end

  def opened?
    return @visibility
  end

  def mine?
    return @mine
  end

  def open
    @visibility = true
  end


end
