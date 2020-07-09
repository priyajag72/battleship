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

  def valid_placement?(ship, coordinates)
    ship.length == coordinates.count && placement_consecutive?(coordinates)
  end

  def placement_consecutive?(coordinates)
    @coordinates = coordinates
    if @coordinates.count == 2
      helper_two_length_consecutive_integers || helper_two_length_consecutive_letters
    elsif @coordinates.count == 3
      helper_three_length_consecutive_integers || helper_three_length_consecutive_letters
    else
      p "Ooops"
    end
  end

  def convert_coord(coordinates)
    integer_coord = []
    integer_coord = @coordinates.map do |coord|
      coord.gsub(/\D/, "").to_i
    end
    integer_coord
  end

  def convert_coord_alpha(coordinates)
    alpha_coord = []
    alpha_coord = @coordinates.map do |coord|
      coord.gsub(/\d/, "")
    end
    alpha_coord
  end

# helper horizontal 2
  def helper_two_length_consecutive_integers
    convert_coord_alpha(@coordinates).sort.each_cons(2).all? { |a,b| a == b } && convert_coord(@coordinates).each_cons(2).all? { |x,y| y == x + 1 }
  end

# helper horizontal 3
  def helper_three_length_consecutive_integers
    convert_coord_alpha(@coordinates).sort.each_cons(3).all? { |a,b,c| (a == b) && (b == c) } &&
    convert_coord(@coordinates).each_cons(3).all? { |x,y,z| (y == x + 1) && (z == y + 1) }
  end

# helper vertical 2
  def helper_two_length_consecutive_letters
    if convert_coord_alpha(@coordinates)[0].downcase == "a"
      convert_coord_alpha(@coordintes)[1].downcase == "b" && convert_coord(@coordinates).sort.each_cons(2).all? { |x,y| x == y }
    elsif convert_coord_alpha(@coordinates)[0].downcase == "b"
      convert_coord_alpha(@coordintes)[1].downcase == "c" && convert_coord(@coordinates).sort.each_cons(2).all? { |x,y| x == y }
    elsif convert_coord_alpha(@coordinates)[0].downcase == "c"
      convert_coord_alpha(@coordintes)[1].downcase == "d" && convert_coord(@coordinates).sort.each_cons(2).all? { |x,y| x == y }
    else
      p "Oops vertical 2"
    end
  end

# helper vertical 3
  def helper_three_length_consecutive_letters
    if convert_coord_alpha(@coordinates)[0].downcase == "a" && convert_coord_alpha(@coordintes)[1].downcase == "b"
      convert_coord_alpha(@coordintes)[2].downcase == "c" && convert_coord(@coordinates).sort.each_cons(3).all? { |x,y,z| (x == y) && (y == z) }
    elsif convert_coord_alpha(@coordinates)[0].downcase == "b" && convert_coord_alpha(@coordintes)[1].downcase == "c"
      convert_coord_alpha(@coordintes)[1].downcase == "d" && convert_coord(@coordinates).sort.each_cons(3).all? { |x,y,z| (x == y) && (y == z) }
    else
      helper_three_length_consecutive_integers
    end
  end

end
