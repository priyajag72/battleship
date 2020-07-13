class Game

  attr_reader :user, :auto, :turn_counter, :turn_coord

  attr_writer

  def initialize(user, auto)
    @user = user
    @auto = auto
    @turn_counter = 0
    @turn_coord = nil
  end

  def display_board
    message_turn + message_computer_display + message_player_display
  end
  # readability = ln 20 has a helper!!!!!!!!!
  def fire(declarer, coordinate)
    if declarer == @user
      @auto.board.cells[coordinate].fire_upon # Which objects actually use this
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
  def user_input
    @turn_coord = gets.chomp.upcase[0..1]
  end

  def message_user_input
    p "Enter the coordinate for your shot"
    print "> "
    user_input
    if @auto.board.cells[user_input].fired_upon?
      message_error_fired_upon
    else
      checking_user_coordinates
    end
    checking_user_coordinates
    puts user_input
  end

  def valid_user_coordinate?(coordinate)
    @user.board.valid_coordinate?(user_input)
  end

  def checking_user_coordinates
    loop do
      message_error_user_input
      valid_user_coordinate?(user_input)
    break if (valid_user_coordinate?(user_input) == true)
    end
  end

  def message_error_user_input
    until valid_user_coordinate?(user_input)
      p "You have input invalid coordinates for your board. Please try again."
      print "> "
      user_input
    end
  end

  def message_error_fired_upon
    until @auto.board.cells[user_input].fired_upon? == false
      p "MISFIRE! You are trying to fire on a cell that you have already fired upon!\nPlease try again!"
      print "> "
      user_input
      if @auto.board.cells[user_input] == nil
        message_error_user_input
      end
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
