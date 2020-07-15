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
        collect_user_input_for_ships
      end
  end

  def collect_user_input_for_ships
    @ships.each do |ship|
      puts "\nEnter the squares for the #{ship.name} (#{ship.length} spaces) > "
      user_ship_coords = gets.chomp.upcase.split(/ /)
      result = @board.valid_placement?(ship, user_ship_coords)
    if result == false
      until this_ship_placed?(ship)
        puts "Those are invalid coordinates. Please try again: \n Please put #{ship.length} coordinates with spaces in between."
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

  def auto_generate_coordinates
    @ships.each do |ship|
      until this_ship_placed?(ship)
        coords_by_ship_length(ship)
        @board.valid_placement?(ship, @auto_coords)
        @board.validated_placement
      end
    end
  end

  def coords_by_ship_length(ship)
    @auto_coords = []
    possible = @board.cells.keys.shuffle
    ship.length.times do
      @auto_coords << possible[0]
      possible.rotate!
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

  def cell_fired_upon?(coord)
    @board.cells[coord].fired_upon?
  end
end
