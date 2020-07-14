class Game

  attr_reader :user, :auto, :turn_counter, :turn_coord

  def initialize(user, auto)
    @user = user
    @auto = auto
    @turn_counter = 0
    @turn_coord = nil
  end

  def display_board
    message_turn
    message_computer_display
    message_player_display
  end

  def fire(declarer, coordinate)
    if declarer == @user
      @auto.board.cells[coordinate].fire_upon
    elsif declarer == @auto
      @user.board.cells[coordinate].fire_upon
    end
    results(declarer, coordinate)
  end

  def results(declarer, coordinate)
    
  end

  def fire_coordinate(declarer)
    case declarer
      when @user
        # message_user_input
        fire(@user, message_user_input)
      when @auto
        fire(@auto, auto_generate_single_coordinate)
    end
  end

  # ============ HELPERS FOR DISPLAY ============
  def message_turn
    @turn_counter += 1
    print "~~~~~~~~~~~~~ TURN ##{@turn_counter} ~~~~~~~~~~~~~\n"
  end

  def message_computer_board
  end

  def message_computer_display
    print "=============COMPUTER BOARD=============\n"
    # message_computer_board
    @auto.board.render
  end

  def message_player_board
  end

  def message_player_display
    print "==============PLAYER BOARD==============\n"
    # message_player_board
    @user.board.render(true)
  end
  # ============================================


  def start
    main_menu
    players_setup_ships
    until winner != nil
      print display_board
      fire_coordinate(@auto)
      fire_coordinate(@user)
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

  # ============ HELPERS FOR FIRE COORDINATE ============
  def message_user_input
    p "Enter the coordinate for your shot"
    print "> "
    @turn_coord = gets.chomp.upcase[0..1]
    checking_user_coordinates
    if @auto.board.cells[@turn_coord].fired_upon?
      message_error_fired_upon
    else
      checking_user_coordinates
    end
    @turn_coord
  end

  def message_error_fired_upon
    until @auto.board.cells[@turn_coord].fired_upon? == false
      p "MISFIRE! You are trying to fire on a cell that you have already fired upon! Please try again!"
      print "> "
      @turn_coord = gets.chomp.upcase[0..1]
      if @auto.board.cells[@turn_coord] == nil
        message_error_user_input
      end
    end
  end


  def leave_game
    exit
  end

  def players_setup_ships
    print message_computer_display
    print message_player_display
    @auto.ship_setup
    print "\nI have laid out my ships on the grid.\nYou now need to lay out your two ships.\nThe Cruiser is three units long\n and the Submarine is two units long."
    @user.ship_setup
  end



  def winner
    if @auto.ships.sum {|ship| ship.health } == 0
      print  "=============You won!=============\n"
      end_game
    elsif @user.ships.sum { |ship| ship.health } == 0
      print  "=============I won!=============\n"
      end_game
    else
      nil
    end
  end

  def end_game
    main_menu
  end


  def checking_user_coordinates
    loop do
      message_error_user_input
      valid_user_coordinate?(@turn_coord)
    break if (valid_user_coordinate?(@turn_coord) == true)
    end
  end

  def message_error_user_input
    until valid_user_coordinate?(@turn_coord)
      p "You have input invalid coordinates for your board. Please try again."
      print "> "
      @turn_coord = gets.chomp.upcase[0..1]
    end
  end

  def valid_user_coordinate?(coordinate)
    @user.board.valid_coordinate?(@turn_coord)
  end

  def auto_generate_single_coordinate
    possible = @user.board.cells.keys.shuffle
    auto_cord = possible[0].to_s
    possible.rotate!
    auto_cord
    #already hit guard
  end
  # ====================================================


end
