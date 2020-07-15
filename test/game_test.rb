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

  def test_it_can_call_correct_render_board
    skip
    # Needs update with Mocks/Stubs
    assert_equal nil, @game.display_board
  end

  def test_it_prints_first_line_to_user_as_turn_counter
    skip
    # Needs update with Mocks/Stubs
    assert_equal "~~~~~~~~~~~~~ TURN #1 ~~~~~~~~~~~~~\n", @game.message_turn
    @turn_counter = 1
    assert_equal "~~~~~~~~~~~~~ TURN #2 ~~~~~~~~~~~~~\n", @game.message_turn
  end

  def test_it_will_display_the_computer_board_renders_with_hidden_ships
    skip
    # Needs update with Mocks/Stubs
    assert_equal Hash, @game.message_computer_display.class
  end

  def test_it_will_display_the_player_board_renders_with_revealed_ships
    skip
    # Needs update with Mocks/Stubs
    assert_equal Hash, @game.message_player_display.class
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
    assert_equal false, @game.user.board.cells["A1"].fired_upon?

    @game.fire(@auto, "A1")
    assert_equal true, @game.user.board.cells["A1"].fired_upon?
    assert_equal "H", @game.user.board.cells["A1"].render

    # auto attempt to fire on D4
      # produce user D4 = M
    assert_equal false, @game.user.board.cells["D4"].fired_upon?
    @game.fire(@auto, "D4")
    assert_equal true, @game.user.board.cells["D4"].fired_upon?
    assert_equal "M", @game.user.board.cells["D4"].render
    assert_equal "H", @game.user.board.cells["A1"].render

    # auto attempt to fire on C2, C3, D3
      # produce user C2, C3, D3 = X
    assert_equal false, @game.user.board.cells["C2"].fired_upon?
    @game.fire(@auto, "C2")
    assert_equal true, @game.user.board.cells["C2"].fired_upon?
    assert_equal "M", @game.user.board.cells["C2"].render

    assert_equal false, @game.user.board.cells["C3"].fired_upon?
    @game.fire(@auto, "C3")
    assert_equal true, @game.user.board.cells["C3"].fired_upon?
    assert_equal "H", @game.user.board.cells["C3"].render

    assert_equal false, @game.user.board.cells["D3"].fired_upon?
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
    # Needs update with Mocks/Stubs
    # In terminal, inputting "A1A2A3"
    @game.message_user_input
    assert_equal 2, @game.turn_coord.length
  end

  # def test_it_checks_user_fire_coordinate_input_for_fired_upon_cell_value_is_true
  # skip
  # Needs update with Mocks/Stubs

  #   @game.fire(@user, "B2")
  #   # In terminal, inputting B2
  #   @game.message_user_input
  #   assert_equal true, @game.auto.board.cells["B2"].fired_upon?
  # end

  def test_it_displays_fired_upon_error_message_and_resets_the_loop
    skip
    # Needs update with Mocks/Stubs

    assert_equal false, @game.auto.board.cells["B2"].fired_upon?

    @game.fire(@user, "B2")
    @game.auto.board.cells["B2"].fire_upon
    # In terminal, inputting B2
    @game.message_user_input
    assert_equal true, @game.auto.board.cells["B2"].fired_upon?
    # In terminal, inputting C4 when error message appears
    assert_equal "C4", @game.turn_coord
  end

  def test_it_displays_fired_upon_error_message_and_resets_the_loop_if_user_enters_two_or_more_cells_that_have_been_fired_on
    skip
    # Needs update with Mocks/Stubs

    @game.fire(@user, "B2")
    @game.fire(@user, "C4")
    # In terminal, inputting B2
    # In terminal, inputting C4
    @game.message_user_input
    assert_equal true, @game.auto.board.cells["B2"].fired_upon?
    # In terminal, inputting D1 when error message appears
    assert_equal "D1", @game.turn_coord

    # Come back to this test when helper methods are finished and tested.
  end

  def test_it_can_check_user_input_for_valid_coordinates
    skip
    # Needs update with Mocks/Stubs

    @game.message_user_input
    # In terminal, initial input is B6, then B1
    # (which is off the current board size). Expected response is error message and opportunity to store appropriate coordinate.
    assert_equal "B1", @game.turn_coord
  end

  def test_it_can_check_user_input_for_valid_coordinates_for_two_or_more_errors
    skip
    # Needs update with Mocks/Stubs

    @game.message_user_input
    # In terminal, initial input is B6 and G9, then B1
    assert_equal "B1", @game.turn_coord
  end

  def test_it_can_check_valid_firing_coordinate_based_off_player_board_cells
    skip
    # Needs update with Mocks/Stubs


    @game.message_user_input
    # In terminal, input tests X9, then D2
    assert_equal "D2", @game.turn_coord
  end

  def test_it_can_get_auto_coordinates
    skip
    # Needs update with Mocks/Stubs

    @game.fire(@user, "B2")
    @game.fire(@user, "C3")
    # @game.fire(@user, @game.fire_coordinate(@user))

    # assert_equal true, @game.auto.board.cells["B2"].fired_upon?
    # assert_equal "M", @game.auto.board.cells["B2"].render
  end

  def test_it_can_setup_ships
    skip

    # HERE
    auto_cruiser = Ship.new("Cruiser", 3)
    auto_submarine = Ship.new("Submarine", 2)
    user_cruiser = Ship.new("Cruiser", 3)
    user_submarine = Ship.new("Submarine", 2)

    auto_board = Board.new
    auto_board.generate_cells
    user_board = Board.new
    user_board.generate_cells

    auto = Player.new(:auto, auto_board)
    user = Player.new(:user, user_board)

    auto.add_ship(auto_cruiser)
    auto.add_ship(auto_submarine)
    user.add_ship(user_cruiser)
    user.add_ship(user_submarine)
    game = Game.new(user, auto)

    assert_nil game.players_setup_ships
  end

  def test_it_can_determine_winner
    skip

    # THIS TEST DOES NOT CURRENTLY RUN CORRECTLY

    auto_cruiser = Ship.new("Cruiser", 3)
    auto_submarine = Ship.new("Submarine", 2)
    user_cruiser = Ship.new("Cruiser", 3)
    user_submarine = Ship.new("Submarine", 2)

    auto_board = Board.new
    auto_board.generate_cells
    user_board = Board.new
    user_board.generate_cells

    auto = Player.new(:auto, auto_board)
    user = Player.new(:user, user_board)


    auto.add_ship(auto_cruiser)
    auto.add_ship(auto_submarine)
    user.add_ship(user_cruiser)
    user.add_ship(user_submarine)
    game = Game.new(user, auto)

        auto.board.place(user_cruiser, ["B1", "C1", "D1"])
    auto.board.place(user_submarine, ["A1", "A2"])
    user.board.place(user_cruiser, ["A1", "A2", "A3"])
    user.board.place(user_submarine, ["C3", "D3"])

    assert_nil game.winner

    game.user.ships[0].hit
    game.user.ships[0].hit
    game.user.ships[0].hit

    assert_equal 0, user.ships[0].health

    game.user.ships[1].hit
    game.user.ships[1].hit

    assert_equal 0, user.ships[1].health

    # assert_equal true, game.all_ships_sunk?(user)
    assert_equal "I won!", game.winner

    #update with game.fire method to fully test functionality
  end

  def test_it_can_auto_generate_single_coordinate
    skip
    # Needs update with Mocks/Stubs

    auto_cruiser = Ship.new("Cruiser", 3)
    auto_submarine = Ship.new("Submarine", 2)
    user_cruiser = Ship.new("Cruiser", 3)
    user_submarine = Ship.new("Submarine", 2)

    auto_board = Board.new
    auto_board.generate_cells
    user_board = Board.new
    user_board.generate_cells

    auto = Player.new(:auto, auto_board)
    user = Player.new(:user, user_board)


    auto.add_ship(auto_cruiser)
    auto.add_ship(auto_submarine)
    user.add_ship(user_cruiser)
    user.add_ship(user_submarine)
    game = Game.new(user, auto)

    assert_equal "", game.auto_generate_single_coordinate
  end



end
