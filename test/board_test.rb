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
    @board.valid_placement?(@sub, ["A1", "A2"])
    @board.number_coordinates
    @board.letter_coordinates
    @board.ship_coordinates
    @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    @board.number_coordinates
    @board.letter_coordinates
    @board.ship_coordinates
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@sub, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@sub, ["A2", "A3"])
  end

  def test_valid_placement_is_consecutive
    @board.valid_placement?(@sub, ["A1", "A2"])
    @board.number_coordinates
    @board.letter_coordinates
    @board.ship_coordinates
    @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    @board.number_coordinates
    @board.letter_coordinates
    @board.ship_coordinates
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@sub, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@sub, ["C1", "B1"])
    assert_equal true, @board.valid_placement?(@sub, ["A1", "B1"])
    assert_equal true, @board.valid_placement?(@cruiser, ["C1", "C2", "C3"])
  end

  def test_valid_number_coordinates_for_cruiser
    @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    assert_equal [["1", "2", "3"], ["2", "3", "4"]], @board.number_coordinates
  end

  def test_valid_number_coordinates_for_sub
    @board.valid_placement?(@sub, ["A1", "B1"])
    assert_equal [["1", "2"], ["2", "3"], ["3", "4"]], @board.number_coordinates
  end

  def test_valid_letter_coordinates_for_cruiser
    @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    assert_equal [["A", "B", "C"], ["B", "C", "D"]], @board.letter_coordinates
  end

  def test_valid_letter_coordinates_for_sub
    @board.valid_placement?(@sub, ["A1", "A2"])
    assert_equal [["A", "B"], ["B", "C"], ["C", "D"]], @board.letter_coordinates
  end

  def test_it_can_generate_valid_ship_coordinates_for_cruiser
    @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    @board.number_coordinates
    @board.letter_coordinates
    expected_cruiser = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"], ["A4", "B4", "C4"], ["B1", "C1", "D1"], ["B2", "C2", "D2"], ["B3", "C3", "D3"], ["B4", "C4", "D4"]]
    assert_equal expected_cruiser, @board.ship_coordinates
  end

  def test_it_can_generate_valid_ship_coordinates_for_sub
    @board.valid_placement?(@sub, ["A1", "A2"])
    @board.number_coordinates
    @board.letter_coordinates
    expected_sub = [["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["A2", "B2"], ["A3", "B3"], ["A4", "B4"], ["B1", "C1"], ["B2", "C2"], ["B3", "C3"], ["B4", "C4"], ["C1", "D1"], ["C2", "D2"], ["C3", "D3"], ["C4", "D4"]]
    assert_equal expected_sub, @board.ship_coordinates
  end

  def test_adds_all_valid_coordinates_with_valid_placement?
    @board.valid_placement?(@sub, ["A1", "A2"])
    @board.number_coordinates
    @board.letter_coordinates
    @board.valid_placement?(@cruiser, ["A1", "A2", "A3"])
    @board.number_coordinates
    @board.letter_coordinates
    expected = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"], ["A4", "B4", "C4"], ["B1", "C1", "D1"], ["B2", "C2", "D2"], ["B3", "C3", "D3"], ["B4", "C4", "D4"], ["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["A2", "B2"], ["A3", "B3"], ["A4", "B4"], ["B1", "C1"], ["B2", "C2"], ["B3", "C3"], ["B4", "C4"], ["C1", "D1"], ["C2", "D2"], ["C3", "D3"], ["C4", "D4"]]
    assert_equal expected.sort, @board.ship_coordinates.sort
  end
end
