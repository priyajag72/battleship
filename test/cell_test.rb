require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/ship_playground'
require './lib/cell'

class CellTest < Minitest::Test

  def test_it_exists
    cell = Cell.new("B4")
    assert_instance_of Cell, cell
  end

  def test_it_has_readable_attributes
    cell = Cell.new("B4")
    assert_equal "B4", cell.coordinate
  end

  def test_if_cell_is_empty
    cell = Cell.new("B4")
    assert_equal true, cell.empty?
  end

  def test_cell_not_empty_when_ship_placed
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(cruiser)
    assert_equal false, cell.empty?
  end
end
