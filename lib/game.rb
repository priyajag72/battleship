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

  def fire(declarer, coordinate)
    if declarer == @user
       if @auto.cell_fired_upon?(coordinate) == false
         @auto.board.cells
        desired_coord_to_fire = gets.chomp.upcase
      end

        if @auto.board.valid_coordinate?(desired_coord_to_fire) == false

        else

        end



      # nested if for user error for firing on coordinate that has been fired on
      @auto.board.cells[coordinate].fire_upon
      # require "pry"; binding.pry
    elsif declarer == @auto
    end

  end

  def start
    main_menu
    players_setup_ships
    # determine_winner
    # end_game
  end

  def main_menu
    print "Welcome to BATTLESHIP Enter p to play. Enter q to quit. > "

    response = gets.chomp.downcase

    if response == "q"
      print "Good Bye!"
      leave_game
    elsif response == "p"
      print "Let's play!"
    else response != "p" || "q"
      print "Invalid entry, please enter p to play or q to quit. > "
      response2 = gets.chomp.downcase
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
    require "pry"; binding.pry
    @auto.ship_setup
    @user.ship_setup
  end

end
