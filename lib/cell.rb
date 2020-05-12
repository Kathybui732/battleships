class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate, ship = nil)
    @coordinate = coordinate
    @ship = ship
  end

  def empty?
    @ship == nil
  end

  def place_ship(placed_ship)
    @ship = placed_ship
  end
end
