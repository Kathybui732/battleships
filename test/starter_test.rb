require "minitest/autorun"
require "minitest/pride"
require "mocha/minitest"
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

  def test_it_can_calibrate_board_for_ships
    expected = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"], ["A4", "B4", "C4"], ["B1", "C1", "D1"], ["B2", "C2", "D2"], ["B3", "C3", "D3"], ["B4", "C4", "D4"], ["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["A2", "B2"], ["A3", "B3"], ["A4", "B4"], ["B1", "C1"], ["B2", "C2"], ["B3", "C3"], ["B4", "C4"], ["C1", "D1"], ["C2", "D2"], ["C3", "D3"], ["C4", "D4"]]
    assert_equal expected.sort, @start_game.calibrate_board_for_ships(3, 2).sort
  end

  def test_cpu_can_place_first_ship
    @start_game.calibrate_board_for_ships(3, 2)
    @start_game.cpu_first_placement(@cruiser, 3)
    assert_equal 3, @start_game.placement_1.count
  end

  def test_cpu_can_place_second_ship
    @start_game.calibrate_board_for_ships(3, 2)
    @start_game.cpu_first_placement(@cruiser, 3)
    @start_game.cpu_second_placement(@sub, 2)
    assert_equal 2, @start_game.placement_2.count
  end

  def test_it_can_create_ship_1
    @start_game.create_ship_1("Titanic", 4)
    assert_instance_of Ship, @start_game.player_ship_1
    assert_instance_of Ship, @start_game.cpu_ship_1
  end

  def test_it_can_create_ship_2
    @start_game.create_ship_2("Titanic", 4)
    assert_instance_of Ship, @start_game.player_ship_2
    assert_instance_of Ship, @start_game.cpu_ship_2
  end

  def test_it_can_create_valid_cells
    @start_game.calibrate_board_for_ships(3, 2)
    expected = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    assert_equal expected, @start_game.create_valid_cells
  end

  def test_user_input
    start_game = mock("Starter")
    start_game.expects(:user_input).returns("p")

    assert_equal "p", start_game.user_input
  end

  def test_player_first_placement
    start_game = mock("Starter")
    start_game.expects(:player_first_placement).returns("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")

    expected = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected, start_game.player_first_placement(@sub)
  end

  def test_player_first_placement_true
    start_game = mock("Starter")
    start_game.expects(:player_first_placement).returns("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")

    expected = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
    assert_equal expected, start_game.player_first_placement(@sub)
  end
end
