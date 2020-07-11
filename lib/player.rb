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
        end
        require "pry"; binding.pry
        # this places a ship
      end
      # board.valid_multi_coordinates?(coordinates)
      # # this is for checking user/auto input of setup coords
      # board.valid_coordinate?(coordinate)
      # # this is for checking user/auto input of fire coords
    end

  end


end
