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
    cell = Cell.new("B4")

    cruiser = mock("Cruiser")

    cruiser.stubs(:place_ship).returns("Cruiser", 3)

    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship

    assert_equal false, cell.empty?
  end

  def test_it_can_be_fired_upon
    cell = Cell.new("B4")

    cruiser = mock("Cruiser")

    cruiser.stubs(:health).returns(3)

    cell.place_ship(cruiser)

    assert_equal false, cell.fired_upon?

    cell.fire_upon

    assert_equal 2, cell.ship.health

    assert_equal true, cell.fired_upon?

  end



end
