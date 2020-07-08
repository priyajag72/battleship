require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/ship"
require "./lib/cell"
require "./lib/board"

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new
    assert_instance_of Board, board
  end

  def test_it_has_attributes

    cell_1 = Cell.new("A1")
    cell_2 = Cell.new("A2")
    cell_3 = Cell.new("A3")
    cell_4 = Cell.new("A4")
    cell_5 = Cell.new("B1")
    cell_6 = Cell.new("B2")
    cell_7 = Cell.new("B3")
    cell_8 = Cell.new("B4")
    cell_9 = Cell.new("C1")
    cell_10 = Cell.new("C2")
    cell_11 = Cell.new("C3")
    cell_12 = Cell.new("C4")
    cell_13 = Cell.new("D1")
    cell_14 = Cell.new("D2")
    cell_15 = Cell.new("D3")
    cell_16 = Cell.new("D4")
    board = Board.new

    expected = {
     "A1" => cell_1,
     "A2" => cell_2,
     "A3" => cell_3,
     "A4" => cell_4,
     "B1" => cell_5,
     "B2" => cell_6,
     "B3" => cell_7,
     "B4" => cell_8,
     "C1" => cell_9,
     "C2" => cell_10,
     "C3" => cell_11,
     "C4" => cell_12,
     "D1" => cell_13,
     "D2" => cell_14,
     "D3" => cell_15,
     "D4" => cell_16
    }
    assert_equal expected, board.cells
  end

end
