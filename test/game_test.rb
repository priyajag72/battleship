require "minitest/autorun"
require "minitest/pride"
require "./lib/ship"
require "./lib/board"
require "./lib/game"

class GameTest < Minitest::Test

  def test_it_exists
    board = Board.new
    # board.generate_cells #MOVED GENERATE C
    cruiser_ui = Ship.new("Cruiser", 3)
    cruiser_auto = Ship.new("Cruiser", 3)
    submarine_ui = Ship.new("Submarine", 2)
    submarine_auto = Ship.new("Submarine", 2)
    user = Player.new
    computer = Player.new
    turn = Turn.new
    shot = Shot.new(board)
    game = Game.new(user, computer)


    assert_instance_of Game, game
    assert_instance_of Turn, turn
    assert_instance_of Player, computer
    assert_instance_of Ship, cruiser_ui
    assert_instance_of Board, board
  end

  def test_it_can_provide_a_message_when_shot
    # board.generate_cells #MOVED GENERATE CELLS TO INITIALIZE
    cruiser_ui = Ship.new("Cruiser", 3)
    cruiser_auto = Ship.new("Cruiser", 3)
    submarine_ui = Ship.new("Submarine", 2)
    submarine_auto = Ship.new("Submarine", 2)

    board_computer = Board.new
    assert_equal true, board_computer.valid_placement?(["A1", "A2", "A3"])
    board_computer.place(cruiser_auto, ["A1", "A2", "A3"])
    assert_equal false, board_computer.valid_placement?(submarine_auto, ["A1", "A2"])

    board_user = Board.new
    user = Player.new
    computer = Player.new
    turn = Turn.new
    shot = Shot.new(board)
    game = Game.new(user, computer)

    assert_equal "Prints this message", shot.print_message_to_fire
  end

end
