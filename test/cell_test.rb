require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/cell"

class CellTest < Minitest::Test

  def test_it_exists
    cell = Cell.new("B4")
    assert_instance_of Cell, cell
  end

  def test_it_has_attributes
    cell = Cell.new("B4")
    assert_equal "B4", cell.coordinate
    assert_nil cell.ship
  end

end
