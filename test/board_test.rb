require "minitest/autorun"
require "minitest/nyan_cat"
# require "mocha/minitest"
require "./lib/ship"
require "./lib/cell"
require "./lib/board"

class BoardTest < Minitest::Test

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

  def test_it_has_equal_quantity_of_coordinates_to_length_of_ship
    board = Board.new
    board.generate_cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

  def test_it_has_consecutive_coordinates_to_place_ship
    board = Board.new
    board.generate_cells
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    # CAN go horizontal for length 2
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])

    # CAN go horizontal for length 3
    assert_equal true, board.valid_placement?(cruiser, ["A1", "A2", "A3"])

    # CAN go vertical for length 2
    assert_equal true, board.valid_placement?(submarine, ["A1", "B1"])

    # CAN go vertical for length 3
    assert_equal true, board.valid_placement?(cruiser, ["A1", "B1", "C1"])

    # can't skip 1 horizontally
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])

    # # can't skip 1 vertically
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    #
    # # can't go backwards horizontally
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    #
    # # can't go backwards vertically
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])

  end
end
