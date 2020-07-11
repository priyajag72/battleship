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
    @fired_upon = true
    if @ship != nil
      @ship.health -= 1
    end
  end

  def fired_upon?
    @fired_upon
  end

  def render(reveal=false)
    if @fired_upon == true && @ship == nil
      "M"
    elsif reveal == true && @ship != nil
      "S"
    elsif @ship != nil && @ship.sunk?
      "X"
    elsif @fired_upon == true && @ship != nil
      "H"
    else reveal == false
      "."
    end
  end
end
