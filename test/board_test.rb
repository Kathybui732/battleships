require "minitest/autorun"
require "minitest/pride"
require "./lib/board"
require "./lib/ship"
require "./lib/cell"
require "pry"

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @sub = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_board_has_cells
    assert_equal Hash, @board.cells.class
    assert_equal 16, @board.cells.count
  end

  def test_is_has_valid_coordinate
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_it_has_valid_coordinate_length
    @board.ship_coordinates(2)
    @board.ship_coordinates(3)
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@sub, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@sub, ["A2", "A3"])
  end

  def test_valid_placement_is_consecutive
    @board.ship_coordinates(2)
    @board.ship_coordinates(3)
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@sub, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@sub, ["C1", "B1"])
    assert_equal true, @board.valid_placement?(@sub, ["A1", "B1"])
    assert_equal true, @board.valid_placement?(@cruiser, ["C1", "C2", "C3"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(@sub, ["C2", "D3"])
  end

  def test_valid_number_coordinates_for_cruiser
    @board.ship_coordinates(3)
    assert_equal [["1", "2", "3"], ["2", "3", "4"]], @board.number_coordinates
  end

  def test_valid_number_coordinates_for_sub
    @board.ship_coordinates(2)
    assert_equal [["1", "2"], ["2", "3"], ["3", "4"]], @board.number_coordinates
  end

  def test_valid_letter_coordinates_for_cruiser
    @board.ship_coordinates(3)
    assert_equal [["A", "B", "C"], ["B", "C", "D"]], @board.letter_coordinates
  end

  def test_valid_letter_coordinates_for_sub
    @board.ship_coordinates(2)
    assert_equal [["A", "B"], ["B", "C"], ["C", "D"]], @board.letter_coordinates
  end

  def test_it_can_generate_valid_ship_coordinates_for_cruiser
    @board.ship_coordinates(3)
    expected_cruiser = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"], ["A4", "B4", "C4"], ["B1", "C1", "D1"], ["B2", "C2", "D2"], ["B3", "C3", "D3"], ["B4", "C4", "D4"]]
    assert_equal expected_cruiser, @board.valid_ship_coordinates
  end

  def test_it_can_generate_valid_ship_coordinates_for_sub
    @board.ship_coordinates(2)
    expected_sub = [["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["A2", "B2"], ["A3", "B3"], ["A4", "B4"], ["B1", "C1"], ["B2", "C2"], ["B3", "C3"], ["B4", "C4"], ["C1", "D1"], ["C2", "D2"], ["C3", "D3"], ["C4", "D4"]]
    assert_equal expected_sub, @board.valid_ship_coordinates
  end

  def test_adds_all_valid_coordinates_with_valid_placement?
    @board.ship_coordinates(3)
    expected = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"], ["A4", "B4", "C4"], ["B1", "C1", "D1"], ["B2", "C2", "D2"], ["B3", "C3", "D3"], ["B4", "C4", "D4"], ["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["A2", "B2"], ["A3", "B3"], ["A4", "B4"], ["B1", "C1"], ["B2", "C2"], ["B3", "C3"], ["B4", "C4"], ["C1", "D1"], ["C2", "D2"], ["C3", "D3"], ["C4", "D4"]]
    assert_equal expected.sort, @board.ship_coordinates(2).sort
  end

  def test_it_can_place_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]
    cell_4 = @board.cells["A4"]
    cell_1.ship
    cell_2.ship
    cell_3.ship
    assert_equal true, cell_3.ship == cell_2.ship
    assert_equal false, cell_3.ship == cell_4.ship
    assert_equal ".", cell_3.render
    assert_equal ".", cell_2.render
    assert_equal ".", cell_3.render
    assert_equal "S", cell_3.render(true)
    assert_equal "S", cell_2.render(true)
    assert_equal "S", cell_3.render(true)
    assert_equal ".", cell_4.render
    assert_equal false, cell_3.empty?
    assert_equal false, cell_2.empty?
    assert_equal false, cell_1.empty?
    assert_equal true, cell_4.empty?
  end

  def test_second_ship_valid_placement
    @board.ship_coordinates(3)
    @board.ship_coordinates(2)
    assert_equal true, @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal false, @board.valid_placement?(@sub, ["A1", "B1"])
    assert_equal true, @board.valid_placement?(@sub, ["C1", "D1"])
  end

  def test_it_can_render_board
    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", @board.render
    @board.place(@cruiser, ["A1", "A2", "A3"])
    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", @board.render
    assert_equal "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n", @board.render(true)
  end

  def test_it_can_generate_valid_cells
    @board.ship_coordinates(3)
    @board.ship_coordinates(2)
    expected = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"]
    assert_equal expected, @board.valid_cells
  end
end
