class Player

  attr_reader :type, :board, :ships

  def initialize(type, board)
    @type = type
    @board = board
    @ships = []
  end

  def add_ship(ship)
    @ships << ship
  end



  def ship_setup
    if @type == :auto
      until all_ships_placed?
        auto_generate_coordinates
      end
    else
      until all_ships_placed?
        @ships.each do |ship|
          # Idea 1: The user message can be a helper method (lines 26/27)
          puts "Enter the squares for the #{ship.name} (#{ship.length} spaces)"
          puts "> "
          # Idea 2: This can be a helper method that may be useful even in game (ln 29)
          user_ship_coords = gets.chomp.upcase.split(/ /)
          result = @board.valid_placement?(ship, user_ship_coords)
          if result == false
            until this_ship_placed?(ship)
              # Idea 3: Another helper... thinking ahead of Game terminal outputs and what might be useful to call again (line 34)
              puts "Those are invalid coordinates. Please try again: "
              # See helper method from ln 28... how can this be useful here?(line  36)
              user_ship_coords2 = gets.chomp.upcase.split(/ /)
            @board.valid_placement?(ship, user_ship_coords2)
            @board.validated_placement
            end
          else
            @board.validated_placement
          end
        end
      end
    end
  end

  def auto_generate_coordinates
    @ships.each do |ship|
      until this_ship_placed?(ship)
        auto_coords = []
        possible = @board.cells.keys.shuffle
        ship.length.times do
          auto_coords << possible[0]
          possible.rotate!
        end
        @board.valid_placement?(ship, auto_coords)
        @board.validated_placement
      end
    end
  end


  def this_ship_placed?(ship)
    @board.cells.values.any? do |cell|
      cell.ship == ship
    end
  end

  def ship_count
    @ships.sum do |ship|
      ship.length
    end
  end

  def ships_on_board
    ships_on_board = @board.cells.reduce(0) do |ships_placed_count, cell|
      if cell[1].ship != nil
        ships_placed_count += 1
      end
      ships_placed_count
    end
  end

  def all_ships_placed?
    ship_count == ships_on_board
  end

  # Are we ready to delete below?


  # def ship_setup
  #   if @type == :auto
  #     # helper-method: auto_generation CALLS
  #     # helper-method: player_place_ships
  #     # auto generation
  #     p "type auto"
  #   elsif @type == :user
  #     # Put in a guard for user error
  #
  #     # helper-method: player_place_ships
  #     @ships.each do |ship|
  #       if ship.length == 3
  #         puts "Enter the squares for the Cruiser (3 spaces):"
  #         puts "> "
  #       elsif ship.length == 2
  #         puts "Enter the squares for the Submarine (2 spaces):"
  #         puts "> "
  #       end
  #
  #       user_ship_coords = gets.chomp.upcase.split(/ /)
  #       # Consider loop for user error
  #       if @board.valid_placement?(ship, user_ship_coords) == true
  #         @board.place(ship, user_ship_coords)
  #       elsif @board.valid_placement?(ship, user_ship_coords) == false
  #         loop do
  #           puts "Those are invalid coordinates. Please try again:"
  #           puts "> "
  #           user_ship_coords = gets.chomp.upcase.split(/ /)
  #
  #           if @board.valid_placement?(ship, user_ship_coords) == true
  #             @board.place(ship, user_ship_coords)
  #             # require "pry"; binding.pry
  #             exit # Could be a helper-method
  #           end
  #         end
  #       end
  #     end
  #   end
  # end


end
