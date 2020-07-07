require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exists
    cruiser = Ship.new("Cruiser", 3)
    assert_instance_of Ship, cruiser
  end

  def test_it_has_a_name
    cruiser = Ship.new("Cruiser", 3)
    assert_equal "Cruiser", cruiser.name
  end

  def test_it_has_correct_length
    cruiser = Ship.new("Cruiser", 3)
    assert_equal 3, cruiser.length
  end

  def test_health_calls_correct_length
    cruiser = Ship.new("Cruiser", 3)
    assert_equal 3, cruiser.health
  end
end
