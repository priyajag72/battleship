require "minitest/autorun"
require "minitest/pride"
require "./lib/ship"
require "./lib/board"
require "./lib/game"
require "./lib/player"

class GameTest < Minitest::Test

  def test_it_exists
    game = Game.new
  end

  def test_it_has_a_main_menu
    assert_equal true, game.main_menu

  end


end
