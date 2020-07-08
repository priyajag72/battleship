require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def test_it_exists
    cell = Cell.new("B4")
    assert_instance_of Cell, cell
  end

  def test_if_cell_is_empty
    cell = Cell.new("B4")

  end
  # cruiser = Ship.new("Cruiser", 3)
end
