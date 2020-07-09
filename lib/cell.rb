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
      p "M"
    elsif reveal == true && @ship != nil
      p "S"
    elsif @ship != nil && @ship.sunk?
      p "X"
    elsif @fired_upon == true && @ship != nil
      p "H"
    else
      p "."
    end
  end
end
