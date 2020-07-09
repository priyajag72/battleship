require_relative './cell'
class Board
 attr_reader  :cells
  def initialize
    @cells = Hash.new

  end

  def generate_cells
    generate_local_coordinates.each do |coordinate|
      @cells[coordinate] = Cell.new(coordinate)
    end
  end

  def generate_local_coordinates
    numbers = ("1".."4").to_a
    letters = ("A".."D").to_a
    local_coordinates = []
    letters.each do |letter|
      numbers.each do |number|
        local_coordinates << letter+number
      end
    end
    local_coordinates
  end

  def place(ship_param, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship_param)
    end
  end



end
