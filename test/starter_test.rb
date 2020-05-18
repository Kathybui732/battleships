require "minitest/autorun"
require "minitest/pride"
require "./lib/board"
require "./lib/ship"
require "./lib/cell"
require "./lib/starter"
require "pry"

class StarterTest < Minitest::Test
  def setup
    @cpu_board = Board.new
    @player_board = Board.new
    @start_game = Starter.new(@cpu_board, @player_board)
    @cruiser = Ship.new("Cruiser", 3)
    @sub = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Starter, @start_game
  end

  def test_it_can_calibrate_board
    expected = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"], ["A4", "B4", "C4"], ["B1", "C1", "D1"], ["B2", "C2", "D2"], ["B3", "C3", "D3"], ["B4", "C4", "D4"], ["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["A2", "B2"], ["A3", "B3"], ["A4", "B4"], ["B1", "C1"], ["B2", "C2"], ["B3", "C3"], ["B4", "C4"], ["C1", "D1"], ["C2", "D2"], ["C3", "D3"], ["C4", "D4"]]
    assert_equal expected.sort, @start_game.calibrate_board_for_ships(3, 2).sort
  end

  def test_it_can_place_first_ship
    @start_game.calibrate_board_for_ships(3, 2)
    @start_game.cpu_first_placement(@cruiser, 3)
    assert_equal 3, @start_game.placement_1.count
  end

  def test_it_can_place_second_ship
    @start_game.calibrate_board_for_ships(3, 2)
    @start_game.cpu_first_placement(@cruiser, 3)
    @start_game.cpu_second_placement(@sub, 2)
    assert_equal 2, @start_game.placement_2.count
  end
end
