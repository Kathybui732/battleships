class Starter
  attr_reader :cpu_board, :player_board, :placement_1, :placement_2

  def initialize(cpu_board, player_board)
    @cpu_board = cpu_board
    @player_board = player_board
    @placement_1 = nil
    @placement_2 = nil
  end

  def calibrate_board_for_ships(length_1, length_2)
    @cpu_board.ship_coordinates(length_1)
    @cpu_board.ship_coordinates(length_2)
    @player_board.ship_coordinates(length_1)
    @player_board.ship_coordinates(length_2)
  end

  def cpu_first_placement(ship, length)
    first_placement = @cpu_board.valid_ship_coordinates.select do |array|
      array.count == length
    end
    @placement_1 = first_placement.sample(1).flatten!
    @cpu_board.place(ship, @placement_1)
  end

  def cpu_second_placement(ship, length)
    second_placement = @cpu_board.valid_ship_coordinates.map do |array|
      array.reject do |element|
        element.include?(@placement_1[0]) || element.include?(@placement_1[1]) || element.include?(@placement_1[2])
      end
    end
    @placement_2 = second_placement.sample(1).flatten!
    @cpu_board.place(ship, @placement_2)
  end

end
