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

    @auto.add_ship(@auto_cruiser)
    @auto.add_ship(@auto_submarine)
    @user.add_ship(@user_cruiser)
    @user.add_ship(@user_submarine)

    @auto.board.place(@user_cruiser, ["B1", "C1", "D1"])
    @auto.board.place(@user_submarine, ["A1", "A2"])
    @user.board.place(@user_cruiser, ["A1", "A2", "A3"])
    @user.board.place(@user_submarine, ["C3", "D3"])
    @game = Game.new(@user, @auto)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal @user, @game.user
    assert_equal @auto, @game.auto
  end

  def test_it_can_print_both_auto_and_user_boards_to_terminal
    expected1 = "~~~~~~~~~~~~~ TURN #1 ~~~~~~~~~~~~~\n=============COMPUTER BOARD=============\n 1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n==============PLAYER BOARD==============\n 1 2 3 4 \nA S S S . \nB . . . . \nC . . S . \nD . . S . \n"
    assert_equal expected1, @game.display_board
  end

  def test_it_can_shoot
    # attempt to fire on A1
      # produce computer A1 = H
    @game.fire(@user, "A1")
    assert_equal true, @game.auto.board.cells["A1"].fired_upon?

    # attempt to fire on C3
    # produce computer C3 = M
    # attempt to fire on B1, C1, D1
    # produce computer B1, C1, D1 = X

  end

  def test_DEBUG_board_renders_shot_behavior_for_testing
    skip
    expected2 = "~~~~~~~~~~~~~ TURN #1 ~~~~~~~~~~~~~\n=============COMPUTER BOARD=============\n 1 2 3 4 \nA H . . . \nB . . . . \nC . . . . \nD . . . . \n==============PLAYER BOARD==============\n 1 2 3 4 \nA S S S . \nB . . . . \nC . . S . \nD . . S . \n"

    # attempt to fire on A1
      # produce computer A1 = H

    # attempt to fire on C3
      # produce computer C3 = M

    # attempt to fire on B1, C1, D1
      # produce computer B1, C1, D1 = X

  end

end
