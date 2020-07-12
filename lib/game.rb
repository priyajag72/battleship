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
      turn_coord = gets.chomp.upcase
      require "pry"; binding.pry # Current pause spot. Trying to use gets chomp to auto remove all characters except index0 and index1
      result = user.board.valid_coordinate?(turn_coord)
      if result == false
        puts "Those are invalid coordinates. Please try again: "
        turn_coord = gets.chomp.upcase
      end
    end

  end

end
