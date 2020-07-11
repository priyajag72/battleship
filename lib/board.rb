require_relative './cell'

class Board

 attr_reader  :cells

  def initialize
    generate_cells
  end

  def generate_cells
    @cells = Hash.new
    generate_local_coordinates.each do |coordinate|
      @cells[coordinate] = Cell.new(coordinate)
    end
  end

  def generate_local_coordinates(user_input=false)
    if user_input == false
    numbers = ("1".."4").to_a
    letters = ("A".."D").to_a
    local_coordinates = []
    letters.each do |letter|
      numbers.each do |number|
        local_coordinates << letter+number
      end
    else
      print "What size board would you like?"
      print "WIDTH > "
      width_ui = gets.chomp.to_s
      print "HEIGHT > "
      height_ui = gets.chomp.to_s

      numbers = ("1".."#{width_ui}").to_a

      alphabetic_characters = (65.chr..90.chr).to_a
      tbd_letters_perm1 = alphabetic_characters.repeated_combination(6).to_a
      

      letters = ("A".."#{number_ui.chr}")
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

#helper method - write test
  def valid_coordinates_suite(ship)
    valid_multi_coordinates?(@coordinates) && ship.length == @coordinates.count && placement_consecutive?
  end

  def valid_placement?(ship, coordinates)
    @coordinates = coordinates
    valid_coordinates_suite(ship) && ship_overlap(ship, coordinates)
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

  def render(reveal=false)
      @cells.each do |cell|
        if cell[0]
          require "pry"; binding.pry
        end
      end
      "  1 2 3 4 \n" +
      "A #{cells["A1"].render(reveal)} #{cells["A2"].render(reveal)} #{cells["A3"].render(reveal)} #{cells["A4"].render(reveal)} \n" +
      "B #{cells["B1"].render(reveal)} #{cells["B2"].render(reveal)} #{cells["B3"].render(reveal)} #{cells["B4"].render(reveal)} \n" +
      "C #{cells["C1"].render(reveal)} #{cells["C2"].render(reveal)} #{cells["C3"].render(reveal)} #{cells["C4"].render(reveal)} \n" +
      "D #{cells["D1"].render(reveal)} #{cells["D2"].render(reveal)} #{cells["D3"].render(reveal)} #{cells["D4"].render(reveal)} \n"
  end


end
