class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = ship
    @render = "."
    @fired_upon = false
    @empty = true
  end

  def empty?
    @empty
  end

  def place_ship(placed_ship)
    @render = "S"
    @empty = false
    @ship = placed_ship
  end

  def fired_upon?
    @fired_upon
  end

  def render()
    if fired_upon? && @render == "H" && @ship.health == 0
      @render = "X"
    elsif fired_upon? && @render == "S" && @ship.sunk?
      @render = "X"
    elsif fired_upon? && @render == "S"
      @render = "H"
    elsif fired_upon? && @render == "."
      @render = "M"
    else
      @render
    end
  end

  def fire_upon
    @fired_upon = true
    @ship.hit if @render == "S"
  end
end
