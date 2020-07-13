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
       @auto.board.cells.fired_upon
        desired_coord_to_fire = gets.chomp.upcase

        if @auto.board.valid_coordinate?(desired_coord_to_fire) == false

        else

        end



      # nested if for user error for firing on coordinate that has been fired on
      @auto.board.cells[coordinate].fire_upon
      # require "pry"; binding.pry
    elsif declarer == @auto
    end

  end


end
