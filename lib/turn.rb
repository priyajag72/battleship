class Turn

  attr_reader :player

  def initialize(player_1, player_2)
    @player = player
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
