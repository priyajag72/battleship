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
    @empty = false
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
    if !@fired_upon && reveal == true
      "S"
    elsif !@fired_upon && reveal == false
      "."
    elsif @ship.nil? && @fired_upon
      "M"
    elsif @ship.sunk?
      "X"
    else !@ship.nil? && @fired_upon
      "H"
    end
  end

end
