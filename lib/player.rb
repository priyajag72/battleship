require_relative "./board"

class Player
 #attr_reader
  def initialize(type)
    @board = Board.new
    @type = type
    require "pry"; binding.pry
  end

  def placing_ships
    if @type == "auto"
      print @board.render


    else
    print @board.render(true)
    "Time to place your ships!"
    end
  end

end
