class Turn

  attr_reader :player, :opponent

  def initialize(player, opponent)
    @player = player
    @opponent = opponent
  end

  def display_board
    message_computer_display + message_player_display
  end
  # ============ HELPERS FOR DISPLAY ============
  def message_computer_board
    "=============COMPUTER BOARD=============\n"
  end

  def message_computer_display
    message_computer_board + opponent.board.render
  end

  def message_player_board
    "==============PLAYER BOARD==============\n"
  end

  def message_player_display
    message_player_board + player.board.render(true)
  end
  # ============================================


end
