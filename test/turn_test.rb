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
    @player1 = Player.new(:auto, @board1)
    @player2 = Player.new(:user, @board2)
    # Below - updates turn instantiation to include both players (this way I can access both boards for display purposes)
    # Chose to do player2 first because this is the user, which would typically be what the
    @turn = Turn.new(@player2, @player1)
  end

  def test_it_exists
    assert_instance_of Turn, @turn
  end

  def test_it_has_attributes
    # skip
    assert_equal @player2, @turn.player
    assert_equal @player1, @turn.opponent
  end

  # when turn called, it should print to terminal :auto board (render default false) and :user board (render parameter set to true)
  def test_it_can_print_both_auto_and_user_boards_to_terminal
    # skip
    expected1 = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    expected2 = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . S . \nD . . S . \n"
    expected3 = "~~~~~~~~~~~~~ TURN #1 ~~~~~~~~~~~~~\n=============COMPUTER BOARD=============\n 1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n==============PLAYER BOARD==============\n 1 2 3 4 \nA S S S . \nB . . . . \nC . . S . \nD . . S . \n"
    @player1.add_ship(@cruiser1) # Where does this get written in? Turn (do I need to write a helper method to add ships to player ship array? Seems lika bad place when making dynamic) What about in Player? or Game? If so, how do we make it dynamic for changing number and size of ships later (when board size becomes dynamic)
    @player1.add_ship(@submarine1)
    @player1.ship_setup
    @player2.add_ship(@cruiser2)
    @player2.add_ship(@submarine2)
    # @player2.ship_setup # For when testing user input
    @player2.board.place(@cruiser2, ["A1", "A2", "A3"])
    @player2.board.place(@submarine2, ["C3", "D3"])

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
    # assert_equal , @turn.
  end
    # GUARD: user error input of more than one coord or invalid coord
    # auto input of coord created from this?



  # shoot behavior (results in hit, miss, or sunk)

  # print result of both :auto and :user

  # MUST RECORD RESULT TO BOARD FOR NEW RENDER (in next turn)

end
