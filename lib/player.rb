class Player

  attr_reader :type, :board

  def initialize(type, board)
    @type = type
    @board = board
  end
end
