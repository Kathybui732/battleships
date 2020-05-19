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
    @render
    @empty = false
    @ship = placed_ship
  end

  def fired_upon?
    @fired_upon
  end

  def render(show_ship = false)
    if show_ship == true && @empty == false
      @render = "S"
    elsif fired_upon? && @render == "H" && @ship.health == 0
      @render = "X"
    elsif fired_upon? && @empty == false && @ship.sunk?
      @render = "X"
    elsif fired_upon? && @empty == false
      @render = "H"
    elsif fired_upon? && @empty == true
      @render = "M"
    else
      @render
    end
  end

  def fire_upon
    @fired_upon = true
    @ship.hit if @empty == false
  end
end
