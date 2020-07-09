require "minitest/autorun"
require "minitest/nyan_cat"
require "./lib/ship"
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


  def test_it_can_place_a_ship
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
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)
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

end
