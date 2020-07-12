class Turn

  attr_reader :user, :auto

  def initialize(user, auto)
    @user = user
    @auto = auto
    @turn_counter = 0
  end

    # BELONGS IN GAME
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
            message_computer_board + auto.board.render
          end

          def message_player_board
            "==============PLAYER BOARD==============\n"
          end

          def message_player_display
            message_player_board + user.board.render(true)
          end
          # ============================================

          def shot_input
            p "Enter the coordinate for your shot"
            print "> "
            turn_coord = gets.chomp
            require "pry"; binding.pry
            result = @board.valid_coordinate?(turn_coord)




            # puts "Enter the squares for the #{ship.name} (#{ship.length} spaces)"
            # puts "> "
            # user_ship_coords = gets.chomp.upcase.split(/ /)
            # result = @board.valid_placement?(ship, user_ship_coords)
            if result == false
              until this_ship_placed?(ship)
                puts "Those are invalid coordinates. Please try again: "
                user_ship_coords2 = gets.chomp.upcase.split(/ /)
              @board.valid_placement?(ship, user_ship_coords2)
              @board.validated_placement
              end
            else
              @board.validated_placement
            end
          end


          # 1. Main Menu output
          # 2. Ship Placement Input / Auto Generation
          # 3. Start Loop
          #   a. Turn Counter
          #   b. Display Board (moving over)
          #   c. Get shot input (moving over)
          #   d. Cell change interaction (deals with render change and fired and fired_upon? Look in cell methods!)
          #   e. Print results (from helper method) (access the board with string interpolation of coord (from get shot input) with hit/miss/sunk from cell methods)






end
