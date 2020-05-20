class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @fired_upon = false
    @empty = true
  end

  def empty?
    @empty
  end

  def place_ship(placed_ship)
    @empty = false
    @ship = placed_ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if !fired_upon?
      @fired_upon = true
      @ship.hit if !empty?
    end
  end

  def render(show_ship = false)
    if show_ship == true
      if !empty? && @ship.sunk? && fired_upon?
        "X"
      elsif !empty? && fired_upon?
        "H"
      elsif !empty?
        "S"
      elsif empty? && fired_upon?
        "M"
      else
        "."
      end
    else
      if !empty? && @ship.sunk? && fired_upon?
        "X"
      elsif !empty? && fired_upon?
        "H"
      elsif empty? && fired_upon?
        "M"
      else
        "."
      end
    end
  end
end
