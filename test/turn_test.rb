require "minitest/autorun"
require "minitest/pride"
require "./lib/ship"
require "./lib/board"
require "./lib/player"
require "./lib/turn"

class TurnTest < Minitest::Test

  def setup
    # 1-s are auto
    # 2-s are user input
    @board1 = Board.new
    @board1.generate_cells
    @board2 = Board.new
    @board2.generate_cells
    @cruiser1 = Ship.new("Cruiser", 3)
    @submarine1 = Ship.new("Submarine", 2)
    @cruiser2 = Ship.new("Cruiser", 3)
    @submarine2 = Ship.new("Submarine", 2)
    @auto = Player.new(:auto, @board1)
    @user = Player.new(:user, @board2)
    # Below - updates turn instantiation to include both players (this way I can access both boards for display purposes)
    # Chose to do user first because this is the user, which would typically be what the
    @turn = Turn.new(@user, @auto)
  end

  def test_it_exists
    # skip
    assert_instance_of Turn, @turn
  end

  def test_it_has_attributes
    # skip
    assert_equal @user, @turn.user
    assert_equal @auto, @turn.auto
  end

  # when turn called, it should print to terminal :auto board (render default false) and :user board (render parameter set to true)
  def test_it_can_print_both_auto_and_user_boards_to_terminal
    # skip
    expected1 = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    expected2 = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . S . \nD . . S . \n"
    expected3 = "~~~~~~~~~~~~~ TURN #1 ~~~~~~~~~~~~~\n=============COMPUTER BOARD=============\n 1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n==============PLAYER BOARD==============\n 1 2 3 4 \nA S S S . \nB . . . . \nC . . S . \nD . . S . \n"
    @auto.add_ship(@cruiser1) # Where does this get written in? Turn (do I need to write a helper method to add ships to player ship array? Seems lika bad place when making dynamic) What about in Player? or Game? If so, how do we make it dynamic for changing number and size of ships later (when board size becomes dynamic)
    @auto.add_ship(@submarine1)
    @auto.ship_setup
    @user.add_ship(@cruiser2)
    @user.add_ship(@submarine2)
    # @user.ship_setup # For when testing user input
    @user.board.place(@cruiser2, ["A1", "A2", "A3"])
    @user.board.place(@submarine2, ["C3", "D3"])

    # assert_equal expected1, @turn_auto.display_board
    # assert_equal expected2, @turn_user.display_board
    assert_equal expected3, @turn.display_board
  end

  # NEED TO TEST HELPERS FOR DISPLAY


  # AFTER print to terminal occurs
    # this loop behavior WILL occur in game "start" method

  # user input of coord (singular)
  def test_it_can_get_user_input_for_shot_coordinate
    skip
    assert_equal "", @turn.shot_input
  end
    # GUARD: user error input of more than one coord or invalid coord
    # auto input of coord created from this?



  # shoot behavior (results in hit, miss, or sunk)

  # print result of both :auto and :user

  # MUST RECORD RESULT TO BOARD FOR NEW RENDER (in next turn)
    # More like a Game test in "start" method

end
