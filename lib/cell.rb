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

  def place_ship(cruiser)
    @ship = cruiser
  end

  def fire_upon
    @ship.health -= 1
    @fired_upon = true
  end

  def fired_upon?
    @fired_upon
  end
end
