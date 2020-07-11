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
    assert_instance_of Player, @player1
  end

  def test_it_has_attributes
    assert_equal :auto, @player1.type
    assert_equal :user, @player2.type
    assert_equal @board1, @player1.board
    assert_equal @board2, @player2.board
    assert_equal [], @player1.ships
  end

  def test_it_can_add_ships
    assert_equal [], @player1.ships
    assert_equal [], @player2.ships
    @player1.add_ship(@cruiser1)
    @player1.add_ship(@submarine1)
    assert_equal [@cruiser1, @submarine1], @player1.ships
    @player2.add_ship(@cruiser2)
    @player2.add_ship(@submarine2)
    assert_equal [@cruiser2, @submarine2], @player2.ships
  end

  def test_player_can_place_ship
    @player1.add_ship(@cruiser1)
    @player1.add_ship(@submarine1)
    @player2.add_ship(@cruiser2)
    @player2.add_ship(@submarine2)

    # Tested in pry. Is working currently before auto generation and user error.
  end

end
