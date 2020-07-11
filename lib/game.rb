require "./lib/ship"
require "./lib/board"
require "./lib/player"

class Game
 #attr_reader
  def initialize
    main_menu
  end

  def main_menu
    p "Welcome to BATTLESHIP"
    p "Enter p to play. Enter q to quit."
    user_input = gets.chomp.downcase
    validate_user_input(user_input)

  end

  def validate_user_input(user_input)
    if user_input == "p"
      ship_placement
    elsif user_input == "q"
      exit
    elsif user_input != "q" || "p"
      print "Invalid entry, please enter p to play or q to quit."
      second_attempt = gets.chomp.downcase
        if second_attempt == "p"
          ship_placement
        elsif second_attempt == "q"
          exit
        elsif second_attempt != "q" || "p"
          print "Final Attempt. Invalid entry, please enter p to play or q to quit."
          final_attempt = gets.chomp.downcase
            if final_attempt != "q" || "p"
              2000.times do
                print "You don't deserve to play"
              end
              exit
            elsif final_attempt == "p"
              ship_placement
            else
              exit
            end
        end
    else
      print "You have entered a restricted zone in our Battleship Game. Self-Destruct Initialized."
      exit
    end

  end

  def ship_placement


  end


end
