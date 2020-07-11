require "./lib/ship"
require "./lib/board"

class Game
  def initialize(player1, player2)
    @user = player1
    @computer = player2
  end

  def main_menu
    print "Welcome to BATTLESHIP"
    print "Enter p to play.  Enter q to quit."
    user_input = gets.chomp.downcase
    if user_input == "q"
      break
    elsif user_input != "q" || "p"
      print "Incorrect entry, please try again."
      second_attempt = gets.chomp.downcase
        if second_attempt == "q"
          break
        elsif second_attempt != "q" || "p"
            print "Final Attempt: would you like to play Battleship?"
            final_attempt = gets.chomp.downcase
              if final_attempt != "q" || "p"
                break
              elsif final_attempt == "q"
                break
              else
                start_game
              end
    elsif user_input == "p"
      start_game
        end
      end
    end
  end

  def start_game
    prompt_to_place_ships

    start_game_loop
  end

  def prompt_to_place_ships
    if @user
      get_place_ships
    else
      auto_place_ships
    end
  end

  def auto_place_ships
    until valid_placement

  end

  def get_place_ships
    ""

  end

  def start_game_loop

    turn = Turn.new(@user, @computer)
    until turn.

    if turn.board.cells.

    end
  end

end
#____________________________________________END OF GAME CLASS
class Player
 #attr_reader
  #def initialize(*arg)

  #end

end

class Turn
 #attr_reader
  #def initialize(*arg)

  #end

end

class Shot
 attr_reader  :board
  def initialize(board)
    @board = board
  end

  def print_message_to_fire
    require "pry"; binding.pry


  end

end
