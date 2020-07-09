require "minitest/autorun"
require "minitest/pride"
# require "mocha/minitest"
require "./lib/ship"
require "./lib/cell"
require "./lib/board"

class BoardTest < Minitest::Test

  def test_it_exists
    # skip
    board = Board.new
    assert_instance_of Board, board
  end

  def test_it_has_attributes
    # skip
    board = Board.new
    board.generate_cells

    assert_instance_of Hash, board.cells
    assert_equal 16, board.cells.keys.count
    assert_instance_of Cell, board.cells["A4"]
  end

  def test_it_has_valid_coordinates
    # skip
    board = Board.new
    board.generate_cells
    assert_equal true, board.valid_coordinate?("A4")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_it_can_check_multiple_coordinates
    # skip
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
    # skip
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
    board = Board.new
    board.generate_cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end
end
