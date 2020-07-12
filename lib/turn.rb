class Turn

  attr_reader :player, :opponent

  def initialize(player, opponent)
    @player = player
    @opponent = opponent
  end

















  def display_board
    # if player.type == :auto
    #   player.board.render
    # else
    #   player.board.render(true)
    # end

    "=============COMPUTER BOARD============="
    # require "pry"; binding.pry
    # player.board.render
    "==============PLAYER BOARD=============="
    player.board.render(true)
  end

end
