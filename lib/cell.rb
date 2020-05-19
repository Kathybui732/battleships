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
    if show_ship == true
      if @empty == false && @ship.sunk? && fired_upon?
        @render = "X"
      elsif @empty == false && fired_upon?
        @render = "H"
      elsif @empty == false
        @render = "S"
      elsif @empty == true && fired_upon?
        @render = "M"
      else
        @render
      end
    else
      if @empty == false && @ship.sunk? && fired_upon?
        @render = "X"
      elsif @empty == false && fired_upon?
        @render = "H"
      elsif @empty == true && fired_upon?
        @render = "M"
      else
        @render
      end
    end
  end

  def fire_upon
    if !fired_upon?
      @fired_upon = true
      @ship.hit if @empty == false
    end
  end
end
