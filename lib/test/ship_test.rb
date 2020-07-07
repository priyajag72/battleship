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

  def test_hit_subtracts_one_from_health
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    assert_equal 2, cruiser.health
    cruiser.hit
    assert_equal 1, cruiser.health
  end

  def test_sunk_returns_true_if_health_equals_zero
    cruiser = Ship.new("Cruiser", 3)
    # require 'pry'; binding.pry
    # [1] pry(#<ShipTest>)> cruiser.name
    # => "Cruiser"
    # [2] pry(#<ShipTest>)> cruiser.length
    # => 3
    # [3] pry(#<ShipTest>)> cruiser.health
    # => 3
    # [4] pry(#<ShipTest>)> cruiser.hit
    # => 2
    # [5] pry(#<ShipTest>)> cruiser.health
    # => 2
    # [6] pry(#<ShipTest>)> cruiser.hit
    # => 1
    # [7] pry(#<ShipTest>)> cruiser.health
    # => 1
    # [8] pry(#<ShipTest>)> cruiser.sunk?
    # => false
    # [9] pry(#<ShipTest>)> cruiser.hit
    # => 0
    # [10] pry(#<ShipTest>)> cruiser.sunk?
    # => true
    # [11] pry(#<ShipTest>)> !!!
    3.times {cruiser.hit}
    assert_equal true, cruiser.sunk?
  end

end
