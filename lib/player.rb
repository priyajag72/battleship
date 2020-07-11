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
      # helper-method: auto_generation CALLS
      # helper-method: player_place_ships
      # auto generation
      p "type auto"
    elsif @type == :user
      # Put in a guard for user error

      # helper-method: player_place_ships
      @ships.each do |ship|
        if ship.length == 3
          puts "Enter the squares for the Cruiser (3 spaces):"
          puts "> "
        elsif ship.length == 2
          puts "Enter the squares for the Submarine (2 spaces):"
          puts "> "
        end

        user_ship_coords = gets.chomp.split(/ /)
        # Consider loop for user error
        if @board.valid_placement?(ship, user_ship_coords) == true
          @board.place(ship, user_ship_coords)
        elsif @board.valid_placement?(ship, user_ship_coords) == false
          loop do
            puts "Those are invalid coordinates. Please try again:"
            puts "> "
            user_ship_coords = gets.chomp.split(/ /)

            if @board.valid_placement?(ship, user_ship_coords) == true
              @board.place(ship, user_ship_coords)
              # require "pry"; binding.pry
              exit # Could be a helper-method
            end
          end
        end
      end
    end
  end

  def all_ships_placed?
    ships_count = @ships.sum do |ship|
      ship.length
    end
    ships_on_board = @board.cells.reduce(0) do |ships_placed_count, cell|
      if cell[1].ship != nil
        ships_placed_count += 1
      end
      ships_placed_count
    end
    ships_count == ships_on_board
    # require "pry"; binding.pry
  end

end
