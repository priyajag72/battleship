class Player

  attr_reader :type, :board, :ships

  def initialize(type, board)
    @type = type
    @board = board
    @ships = []
  end

  def add_ship(ship)
    @ships << ship
  end

  def ship_setup
  end


end
