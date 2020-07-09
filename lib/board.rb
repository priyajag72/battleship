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

 def ship_overlap(ship, coordinates)
    desired_coordinates = Hash.new
    coordinates.each do |coordinate|
      desired_coordinates[coordinate] = ship
    end
    cell_availability = desired_coordinates.map do |coordinate, ship|
    @cells[coordinate].ship == nil
    end
    cell_availability.all?(true)
  end

  def valid_coordinate?(coordinate)
     generate_local_coordinates.include?(coordinate)
  end

  def valid_multi_coordinates?(coordinates)
    coordinates_exist_on_board = coordinates.map do |coord|
      valid_coordinate?(coord)
    end
    coordinates_exist_on_board.all?(true)
  end

  def valid_placement?(ship, coordinates)
    @coordinates = coordinates
    ship_overlap(ship, coordinates) && valid_multi_coordinates?(coordinates) && ship.length == coordinates.count && placement_consecutive?
  end

  def placement_consecutive?
    if @coordinates.count == 2
      valid_horizontal_placement_length_two? || valid_vertical_placement_length_two?
    elsif @coordinates.count == 3
      valid_horizontal_placement_length_three? || valid_vertical_placement_length_three?
    else
      p "Ooops"
    end
  end

  def convert_coord_int
    integer_coord = []
    integer_coord = @coordinates.map do |coord|
      coord.gsub(/\D/, "").to_i
    end
    integer_coord
  end

  def convert_coord_alpha
    alpha_coord = []
    alpha_coord = @coordinates.map do |coord|
      coord.gsub(/\d/, "")
    end
    alpha_coord
  end

  def valid_horizontal_placement_length_two?
    convert_coord_alpha.sort.each_cons(2).all? { |alpha1,alpha2| alpha1 == alpha2 } && convert_coord_int.each_cons(2).all? { |num1,num2| num1.next == num2 }
  end

  def valid_horizontal_placement_length_three?
    convert_coord_alpha.sort.each_cons(3).all? { |alpha1,alpha2,alpha3| (alpha1 == alpha2) && (alpha2 == alpha3) } &&
    convert_coord_int.each_cons(3).all? { |num1,num2,num3| (num1.next == num2) && (num2.next == num3) }
  end

  def valid_vertical_placement_length_two?
    if convert_coord_alpha[0] == "A"
      convert_coord_alpha[1] == "B" && convert_coord_int.sort.each_cons(2).all? { |num1,num2| num1 == num2 }
    elsif convert_coord_alpha[0] == "A"
      convert_coord_alpha[1] == "C" && convert_coord_int.sort.each_cons(2).all? { |num1,num2| num1 == num2 }
    elsif convert_coord_alpha[0] == "C"
      convert_coord_alpha[1] == "D" && convert_coord_int.sort.each_cons(2).all? { |num1,num2| num1 == num2 }
    else
      false
    end
  end

  def valid_vertical_placement_length_three?
    if convert_coord_alpha[0] == "A" && convert_coord_alpha[1] == "B"
      convert_coord_alpha[2] == "C" && convert_coord_int.sort.each_cons(3).all? { |num1,num2,num3| (num1 == num2) && (num2 == num3) }
    elsif convert_coord_alpha[0] == "B" && convert_coord_alpha[1] == "C"
      convert_coord_alpha[2] == "D" && convert_coord_int.sort.each_cons(3).all? { |num1,num2,num3| (num1 == num2) && (num2 == num3) }
    else
      false
    end
  end
end
