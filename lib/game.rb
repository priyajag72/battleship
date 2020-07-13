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
      # nested if for user error for firing on coordinate that has been fired on
      @auto.board.cells[coordinate].fire_upon
      # require "pry"; binding.pry
    elsif declarer == @auto
      @user.board.cells[coordinate].fire_upon
    end

  end

  def fire_coordinate(declarer)
    if declarer == @user
      p "Enter the coordinate for your shot"
      print "> "
      turn_coord = gets.chomp
      helper
      return turn_coord
    elsif declarer == @auto
      require "pry"; binding.pry
      auto_generate_single_coordinate
    end

  end

  # ============ HELPERS FOR FIRE COORDINATE ============
  def message_error_user_input
    p "Those are invalid coordinates. Please try again: "
    print "> "
    turn_coord = gets.chomp
    fire_valid_coordinate_user?(turn_coord)
  end

  def fire_valid_coordinate_user?(coordinate)
     if @user.board.cell.fired_upon == false
       message_error_user_input
     else
       @user.board.generate_local_coordinates.include?(coordinate)
     end

  end

  def fire_valid_coordinate_auto?(coordinate)
    @auto.board.cell.fired_upon == false && @auto.board.generate_local_coordinates.include?(auto_generate_single_coordinate)
  end

  def auto_generate_single_coordinate
    possible = @user.board.cells.keys.shuffle
    auto_cord = possible[0].to_s
    possible.rotate!
    auto_cord
  end
  # ====================================================

end
