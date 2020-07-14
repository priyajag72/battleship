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
    until winner != nil
    winner
    #fire

    end
    end_game
  end

  def main_menu
    print "Welcome to BATTLESHIP\n Enter p to play. Enter q to quit. > "
    response = gets.chomp.downcase[0]
    if response == "p"
      puts "Let's play!"
    elsif response == "q"
      puts "See you next time!"
      leave_game
    else
      puts "Invalid entry. Bye!"
      leave_game
    end

  end

  def leave_game
    exit
  end

  def players_setup_ships
    @auto.ship_setup
    @user.ship_setup
  end



  def winner
    if @auto.ships.sum {|ship| ship.health } == 0
      print "You won!"
    elsif @user.ships.sum { |ship| ship.health } == 0
      print "I won!"
    else
      nil
    end
  end

  def end_game
    print "=============PRINT WINNER RESULTS HERE=============\n"
    main_menu
  end


end
