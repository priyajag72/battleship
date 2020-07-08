require_relative './cell'
class Board
 attr_reader  :cells
  def initialize
    @cells = Hash.new

  end

  def generate_cells
    numbers = ("1".."4").to_a
    letters = ("A".."D").to_a

    local_coordinates = []
    letters.each do |letter|
      numbers.each do |number|
        local_coordinates << letter+number
      end
    end

    local_coordinates.each do |coordinate|
      @cells[coordinate] = Cell.new(coordinate)
    end
  end

end
