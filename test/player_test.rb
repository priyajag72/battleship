require "minitest/autorun"
require "minitest/pride"
require "./lib/ship"
require "./lib/board"
require "./lib/player"

class PlayerTest < Minitest::Test

  def test_it_exists
    player = Player.new
    assert_instance_of Player, player
  end

  #def test_it_has_attributes
  #end

end
