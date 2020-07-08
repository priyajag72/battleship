class Cell
 attr_reader  :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @empty = true
    @fired_upon = false
  end

  def empty?
    if @ship == nil
      @empty
    else
      @empty = false
    end
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @ship.hit
    @fired_upon = true
  end

  def fired_upon?
    @fired_upon
  end

  def render(reveal=false)

    if @fired_upon == true && @ship == nil
      "M"
    elsif reveal == true && @ship != nil
      "S"
    elsif @fired_upon == true && @ship != nil
      "H"
    elsif @ship.sunk?
      "X"
    else
      "."
    end
  end
end
