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
    assert_equal true, cell.empty?
  end

  def test_it_can_place_a_ship
    skip
    cell = Cell.new("B4")

    cruiser = mock("Cruiser")

    cruiser.stubs(:place_ship).expects("Cruiser", 3)

    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship

    assert_equal false, cell.empty?
  end

end
