class Cell
  attr_reader :coordinate, :ship, :render

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

  def fire_upon
    if @render == "S" && @ship.health == 1
      @render = "X"
      @ship.hit
    elsif @render == "S"
      @render = "H"
      @ship.hit
    else
      @render = "M"
    end
  end
end
