require "minitest/autorun"
require "minitest/pride"
require "./lib/ship"
require "./lib/board"

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @board.generate_cells
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    board = Board.new
    assert_instance_of Board, board
  end


  def test_it_has_attributes
    board = Board.new
    board.generate_cells

    assert_instance_of Hash, board.cells
    assert_equal 16, board.cells.keys.count
    assert_instance_of Cell, board.cells["A4"]
  end

  def test_it_can_generate_cells
    board = Board.new
    assert_equal Array, board.generate_cells.class
    assert_instance_of Cell, board.cells["D3"]
  end

  def test_it_can_generate_local_coordinates
    board = Board.new
    assert_equal Array, board.generate_local_coordinates.class
  end



  def test_it_can_place_a_ship
    # skip
    board = Board.new
    board.generate_cells
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]
    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship

    expected = (cell_3.ship == cell_2.ship)

    assert_equal true, expected
  end



  def test_it_can_avoid_ship_overlap_placement
    board = Board.new
    board.generate_cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    board.place(cruiser, ["A1", "A2", "A3"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "B2"])
  end


  def test_it_has_valid_coordinates
    board = Board.new
    board.generate_cells
    assert_equal true, board.valid_coordinate?("A4")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end


  def test_it_can_check_multiple_coordinates
    board = Board.new
    board.generate_cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert_equal true, board.valid_multi_coordinates?(["A1", "A2", "A3"])
    assert_equal false, board.valid_multi_coordinates?(["A3", "A4", "A5"])
    assert_equal false, board.valid_multi_coordinates?(["A3", "A4", "A5"])
    assert_equal false, board.valid_multi_coordinates?(["B7", "A1", "Z45"])
    assert_equal true, board.valid_multi_coordinates?(["D2", "D3", "D4"])
    assert_equal false, board.valid_multi_coordinates?(["D2", "D4", "D5"])
    assert_equal false, board.valid_multi_coordinates?(["C3", "D4", "E5"])
  end


  def test_it_has_equal_quantity_of_coordinates_to_length_of_ship
    # skip
    board = Board.new
    board.generate_cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end



  def test_it_has_consecutive_coordinates_to_place_ship
    board = Board.new
    board.generate_cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    assert_equal true, board.valid_placement?(submarine, ["A1", "B1"])
    assert_equal true, board.valid_placement?(cruiser, ["A1", "B1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
    assert_equal false, board.valid_placement?(submarine, ["D1", "E1"])
    assert_equal false, board.valid_placement?(submarine, ["A4", "A5"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2"])
  end


  def test_it_cannot_place_diagonal_coordinates
    # skip
    board = Board.new
    board.generate_cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
    assert_equal false, board.valid_placement?(cruiser, ["B2", "B2", "B3"])
  end


  def test_correct_placement_of_ships_in_coordinates
    # skip
    board = Board.new
    board.generate_cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_it_can_render_a_board
    # skip
    expected1 = print " 1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

    expected2 = print " 1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"

    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal expected1, @board.render
    assert_equal expected2, @board.render(true)
  end

  def test_validated_placement
    board = Board.new
    board.generate_cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    board.validated_placement
    assert_equal cruiser, board.cells["A1"].ship
    assert_equal cruiser, board.cells["A2"].ship
    assert_equal cruiser, board.cells["A3"].ship


    assert_equal true, board.valid_placement?(submarine, ["B1", "B2"])
    board.validated_placement
    assert_equal submarine, board.cells["B1"].ship
    assert_equal submarine, board.cells["B2"].ship

    #a helper method that tests to see if a valid_placement is true and then proceeds to automatically place the ship in question.

  end

end
