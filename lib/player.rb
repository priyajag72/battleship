class Player

  attr_reader :type, :board, :ships

  def initialize(type, board)
    @type = type
    @board = board
    @ships = []
  end


end
