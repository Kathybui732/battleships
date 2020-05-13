class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate, ship = nil)
    @coordinate = coordinate
    @ship = ship
    @render = "."
  end

  def empty?
    @ship == nil
  end

  def place_ship(placed_ship)
    @render = "S"
    @ship = placed_ship
  end

  def fired_upon?
    @render == "X" || @render == "H"
  end

  def render
    if @render == "H" && @ship.health == 0
      @render = "X"
    else
      @render
    end
  end

  def fire_upon
    if @render == "S" && @ship.health < 1
      @ship.hit
      @render = "X"
    elsif @render == "S"
      @ship.hit
      @render = "H"
    elsif @render = "."
      @render = "M"
    end
  end
end
