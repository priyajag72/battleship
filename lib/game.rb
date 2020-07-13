class Game

  attr_reader :user, :auto, :turn_coord

  def initialize(user, auto)
    @user = user
    @auto = auto
    @turn_counter = 0
    @turn_coord = turn_coord
  end

  def display_board
    message_turn + message_computer_display + message_player_display
  end

  def fire(declarer, coordinate)
    if declarer == @user
      @auto.board.cells[coordinate].fire_upon
    elsif declarer == @auto
      @user.board.cells[coordinate].fire_upon
    end

  end

  def fire_coordinate(declarer)
    case declarer
    when @user
      message_user_input
    when @auto
      auto_generate_single_coordinate
    end

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


  # ============ HELPERS FOR FIRE COORDINATE ============
  def message_user_input
    p "Enter the coordinate for your shot"
    print "> "
    @turn_coord = gets.chomp[0..1]
    loop do
      message_error_user_input
      valid_user_coordinate?(@turn_coord)
    break if (valid_user_coordinate?(@turn_coord) == true)
    end
    @turn_coord
  end

  def valid_user_coordinate?(coordinate)
    @user.board.valid_coordinate?(@turn_coord)
  end

  def message_error_user_input
    until valid_user_coordinate?(@turn_coord)
      p "You have input invalid coordinates for your board. Please try again."
      print "> "
      @turn_coord = gets.chomp[0..1]
    end

    until valid_coord_fired_upon?(@turn_coord)
    end
  end

  def valid_coord_fired_upon?(coordinate)
    if @user.board.cells[@turn_coord].fired_upon? == true
      p "MISFIRE! You are trying to fire on a cell that you have already fired upon!\nThe enemy is alerted => YOU HAVE ONE CHANCE TO CHECK YOUR BOARD AND FIRE AGAIN."
      print "> "
      @turn_coord = gets.chomp[0..1]
      require "pry"; binding.pry
      valid_user_coordinate?(@turn_coord)
    else
      true
    end
  end

  def auto_generate_single_coordinate
    possible = @user.board.cells.keys.shuffle
    auto_cord = possible[0].to_s
    possible.rotate!
    auto_cord
  end
  # ====================================================

end
