  class Ship

  attr_reader :name, :length, :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  # def health
  #   # if hit occurs, length reduces by 1
  #   # don't change length
  #   # change health
  #   # return 3
  #   # call method hit
  #   # return 2
  #   # So... it looks like METHOD = hit
  #   # And.... VARIABLE = health
  # end

  def hit
      @health -= 1
  end

  def sunk?
    if health == 0
      true
    else
      false
    end
  end

end
