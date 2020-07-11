require "minitest/autorun"
require "minitest/pride"
require "./lib/ship"
require "./lib/board"
require "./lib/game"

class GameTest < Minitest::Test

  def test_it_exists
    game = Game.new
  end


end
