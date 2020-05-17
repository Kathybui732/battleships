class Starter
  attr_reader :cpu_board, :player_board
  def initialize
    @cpu_board = Board.new
    @player_board = Board.new
    @cruiser_1 = Ship.new("Cruiser", 3)
    @cruiser_2 = Ship.new("Cruiser", 3)
    @sub_1 = Ship.new("Sub", 2)
    @sub_2 = Ship.new("Sub", 2)
  end
    # Change create ship method name
  def default_setup
    @cpu_board.create_ship("sub", 2)
    @cpu_board.number_coordinates
    @cpu_board.letter_coordinates
    @player_board.create_ship("sub", 2)
    @player_board.number_coordinates
    @player_board.letter_coordinates
    @cpu_board.create_ship("cruiser", 3)
    @cpu_board.number_coordinates
    @cpu_board.letter_coordinates
    @cpu_board.ship_coordinates
    @player_board.create_ship("cruiser", 3)
    @player_board.number_coordinates
    @player_board.letter_coordinates
    @player_board.ship_coordinates
  end

  # def cpu_place_ship(ship, length)
  #   until @cpu_board.valid_placement? do
  #     @cpu_board.valid_ship_coordinates.sample(1)
  #     @cpu_board.valid_placement?
  # end

end
