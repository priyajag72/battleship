require "minitest/autorun"
require "minitest/pride"
require "./lib/ship"
require "./lib/board"
require "./lib/player"

class PlayerTest < Minitest::Test

  def setup
    @board1 = Board.new
    @board1.generate_cells
    @board2 = Board.new
    @board2.generate_cells
    @cruiser1 = Ship.new("Cruiser", 3)
    @submarine1 = Ship.new("Submarine", 2)
    @cruiser2 = Ship.new("Cruiser", 3)
    @submarine2 = Ship.new("Submarine", 2)
    @player1 = Player.new(:auto, @board1)
    @player2 = Player.new(:user, @board2)
  end

  def test_it_exists
    player = Player.new
    assert_instance_of Player, player
  end

  def test_it_has_attributes
    # Characteristic 1: user v computer
    # Characteristic 2: access to a board (preferably, a board that is dynamic)
  end

end
