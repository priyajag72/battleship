class Game

  attr_reader :user, :auto

  def initialize(user, auto)
    @user = user
    @auto = auto
    @turn_counter = 0
  end

  def display_board
    message_turn + message_computer_display + message_player_display
  end
  # ============ HELPERS FOR DISPLAY ============
  def message_turn
    @turn_counter += 1
    "~~~~~~~~~~~~~ TURN ##{@turn_counter} ~~~~~~~~~~~~~\n"
  end

  def message_computer_board
    "=============COMPUTER BOARD=============\n"
  end

  def message_computer_display
    message_computer_board + @auto.board.render
  end

  def message_player_board
    "==============PLAYER BOARD==============\n"
  end

  def message_player_display
    message_player_board + @user.board.render(true)
  end
  # ============================================

  def start
    main_menu
    players_setup_ships
    # winner?
    # results of winner
    # end_game
  end

  def main_menu
    print "Welcome to BATTLESHIP Enter p to play. Enter q to quit. > "

    response = gets.chomp.downcase[0]

    if response == "q"
      print "Good Bye!"
      leave_game
    elsif response == "p"
      print "Let's play!"
    else response != "p" || "q"
      print "Invalid entry, please enter p to play or q to quit. > "
      response2 = gets.chomp.downcase[0]
      if response2 == "p"
        print "Let's play!"
      elsif response2 == "q"
        print "Good- bye!"
        leave_game
      else response2 != "p" || "q"
        print "Good- bye!"
        leave_game
      end
    end

  end

  def leave_game
    exit
  end

  def players_setup_ships
    @auto.ship_setup
    @user.ship_setup
  end

  def check_ships_sunk?(player)
    x = player.ships
    z = 0
    x.all?(true) do |ship|
      z == ship.health
    end
  end

  def winner?
    check_ships_sunk?(@auto) || check_ships_sunk?(@user)
  end



end
