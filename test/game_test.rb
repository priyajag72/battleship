require "minitest/autorun"
require "minitest/pride"
require "./lib/ship"
require "./lib/board"
require "./lib/player"
require "./lib/game"

class GameTest < Minitest::Test

  def setup
    @auto_cruiser = Ship.new("Cruiser", 3)
    @auto_submarine = Ship.new("Submarine", 2)
    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)

    @auto_board = Board.new
    @auto_board.generate_cells
    @user_board = Board.new
    @user_board.generate_cells

    @auto = Player.new(:auto, @auto_board)
    @user = Player.new(:user, @user_board)

    @game = Game.new(@user, @auto)
  end

  def test_it_exists
    assert_instance_of  Game, game
  end
end
