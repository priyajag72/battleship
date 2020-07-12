class Turn

  attr_reader :player

  def initialize(player)
    @player = player
  end

  def display_board
    if player.type == :auto
      player.board.render
    else
      player.board.render(true)
    end

  end

end
