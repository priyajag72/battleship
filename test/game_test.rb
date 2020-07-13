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
    # skip
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    # skip
    assert_equal @user, @game.user
    assert_equal @auto, @game.auto
    assert_equal 0, @game.turn_counter
    assert_nil @game.turn_coord
  end

  def test_it_can_print_both_auto_and_user_boards_to_terminal
    # skip
    expected1 = "~~~~~~~~~~~~~ TURN #1 ~~~~~~~~~~~~~\n=============COMPUTER BOARD=============\n 1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n==============PLAYER BOARD==============\n 1 2 3 4 \nA S S S . \nB . . . . \nC . . S . \nD . . S . \n"
    assert_equal expected1, @game.display_board
  end

  def test_it_prints_first_line_to_user_as_turn_counter
    # skip
    assert_equal "~~~~~~~~~~~~~ TURN #1 ~~~~~~~~~~~~~\n", @game.message_turn
    @turn_counter = 1
    assert_equal "~~~~~~~~~~~~~ TURN #2 ~~~~~~~~~~~~~\n", @game.message_turn
  end

  def test_it_will_label_computer_board_for_display
    # skip
    assert_equal "=============COMPUTER BOARD=============\n", @game.message_computer_board
  end

  def test_it_will_display_the_computer_board_and_renders_with_hidden_ships
    # skip
    expected = "=============COMPUTER BOARD=============\n 1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected, @game.message_computer_display
  end

  def test_it_will_label_player_board_for_display
    # skip
    assert_equal "==============PLAYER BOARD==============\n", @game.message_player_board
  end

  def test_it_will_display_the_player_board_and_renders_with_revealed_ships
    # skip
    expected = "==============PLAYER BOARD==============\n 1 2 3 4 \nA S S S . \nB . . . . \nC . . S . \nD . . S . \n"
    assert_equal expected, @game.message_player_display
  end

  def test_it_can_shoot_for_user
    # skip
    # user attempt to fire on A1
      # produce auto A1 = H
    @game.fire(@user, "A1")
    assert_equal true, @game.auto.board.cells["A1"].fired_upon?
    assert_equal "H", @game.auto.board.cells["A1"].render

    # user attempt to fire on C3
      # produce auto C3 = M
    @game.fire(@user, "C3")
    assert_equal true, @game.auto.board.cells["C3"].fired_upon?
    assert_equal "M", @game.auto.board.cells["C3"].render
    assert_equal "H", @game.auto.board.cells["A1"].render

    # user attempt to fire on B1, C1, D1
      # produce auto B1, C1, D1 = X
    @game.fire(@user, "B1")
    assert_equal true, @game.auto.board.cells["B1"].fired_upon?
    assert_equal "H", @game.auto.board.cells["B1"].render

    @game.fire(@user, "C1")
    assert_equal true, @game.auto.board.cells["C1"].fired_upon?
    assert_equal "H", @game.auto.board.cells["C1"].render

    @game.fire(@user, "D1")
    assert_equal true, @game.auto.board.cells["D1"].fired_upon?
    assert_equal "X", @game.auto.board.cells["D1"].render
    assert_equal "X", @game.auto.board.cells["C1"].render
    assert_equal "X", @game.auto.board.cells["B1"].render
    assert_equal "M", @game.auto.board.cells["C3"].render
    assert_equal "H", @game.auto.board.cells["A1"].render

  end

  def test_it_can_shoot_for_auto
    # skip
    # auto attempt to fire on A1
      # produce user A1 = H
    @game.fire(@auto, "A1")
    assert_equal true, @game.user.board.cells["A1"].fired_upon?
    assert_equal "H", @game.user.board.cells["A1"].render

    # auto attempt to fire on D4
      # produce user D4 = M
    @game.fire(@auto, "D4")
    assert_equal true, @game.user.board.cells["D4"].fired_upon?
    assert_equal "M", @game.user.board.cells["D4"].render
    assert_equal "H", @game.user.board.cells["A1"].render

    # auto attempt to fire on C2, C3, D3
      # produce user C2, C3, D3 = X
    @game.fire(@auto, "C2")
    assert_equal true, @game.user.board.cells["C2"].fired_upon?
    assert_equal "M", @game.user.board.cells["C2"].render

    @game.fire(@auto, "C3")
    assert_equal true, @game.user.board.cells["C3"].fired_upon?
    assert_equal "H", @game.user.board.cells["C3"].render

    @game.fire(@auto, "D3")
    assert_equal true, @game.user.board.cells["D3"].fired_upon?
    assert_equal "X", @game.user.board.cells["D3"].render
    assert_equal "X", @game.user.board.cells["C3"].render
    assert_equal "M", @game.user.board.cells["C2"].render
    assert_equal "M", @game.user.board.cells["D4"].render
    assert_equal "H", @game.user.board.cells["A1"].render

  end

  def test_it_will_automatically_remove_excess_characters_past_two_for_user_input
    skip
    # In terminal, inputting "A1A2A3"
    @game.message_user_input
    assert_equal "A1", @game.turn_coord
  end

  def test_it_checks_user_fire_coordinate_input_for_fired_upon_cell_value_is_true
    skip
    @game.fire(@user, "B2")
    # In terminal, inputting B2
    @game.message_user_input
    assert_equal true, @game.auto.board.cells["B2"].fired_upon?
  end

  def test_it_displays_fired_upon_error_message_and_resets_the_loop
    # skip
    @game.fire(@user, "B2")
    # In terminal, inputting B2
    @game.message_user_input
    assert_equal true, @game.auto.board.cells["B2"].fired_upon?
    # In terminal, inputting C4 when error message appears
    assert_equal "C4", @game.turn_coord
  end

  def test_it_displays_fired_upon_error_message_and_resets_the_loop_if_user_enters_two_or_more_cells_that_have_been_fired_on
    # skip
    @game.fire(@user, "B2")
    @game.fire(@user, "C4")
    # In terminal, inputting B2
    # In terminal, inputting C4
    @game.message_user_input
    assert_equal true, @game.auto.board.cells["B2"].fired_upon?
    # In terminal, inputting D1 when error message appears
    assert_equal "D1", @game.turn_coord

  end

  def test_it_can_get_auto_coordinates
    skip
    @game.fire(@user, "B2")
    @game.fire(@user, "C3")
    # @game.fire(@user, @game.fire_coordinate(@user))

    # assert_equal true, @game.auto.board.cells["B2"].fired_upon?
    # assert_equal "M", @game.auto.board.cells["B2"].render
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
