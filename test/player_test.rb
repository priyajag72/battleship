require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
require "./lib/ship"
require "./lib/board"
require "./lib/game"
require "./lib/player"

class PlayerTest < Minitest::Test

  def test_it_exists
    cruiser = Ship.new("Cruiser", 3)
    sub = Ship.new("Submarine", 2)
    player_auto = Player.new("auto")
    player_user = Player.new("user")
    assert_instance_of Player, player_user
  end

  def test_it_has_attributes
  end

end
