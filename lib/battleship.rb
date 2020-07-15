require "./lib/ship"
require "./lib/board"
require "./lib/player"
require "./lib/game"

class Battleship
 #attr_reader
  def initialize
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

    @game = Game.new(@user, @auto)
    @game.start
  end

end
