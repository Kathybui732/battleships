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
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@sub, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@sub, ["A2", "A3"])
  end

  def test_valid_placement_is_consecutive
    skip
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@sub, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@sub, ["C1", "B1"])
    assert_equal true, @board.valid_placement?(@sub, ["A1", "B1"])
    assert_equal true, @board.valid_placement?(@cruiser, ["C1", "C2", "C3"])
  end

  def test_it_has_valid_number_coordinates
    skip
    assert_equal [["1", "2", "3"], ["2", "3", "4"]], @board.number_placement(@cruiser)
    assert_equal [["1", "2"], ["2", "3"], ["3", "4"]], @board.number_placement(@sub)
  end

  def test_it_has_valid_letter_coordinates
    skip
    assert_equal [["A", "B", "C"], ["B", "C", "D"]], @board.letter_coordinates(@cruiser)
    assert_equal [["A", "B"], ["B", "C"], ["C", "D"]], @board.letter_coordinates(@sub)
  end

  def test_it_can_generate_valid_ship_coordinates
    expected_sub = [["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["B1", "C1"], ["C1", "D1"], ["A2", "B2"], ["B2", "C2"], ["C2", "D2"], ["A3", "B3"], ["B3", "C3"], ["C3", "D3"], ["A4", "B4"], ["B4", "C4"], ["C4", "D4"]]
    expected_cruiser = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["B1", "C1", "D1"], ["A2", "B2", "C2"], ["B2", "C2", "D2"], ["A3", "B3", "C3"], ["B3", "C3", "D3"], ["A4", "B4", "C4"], ["B4", "C4", "D4"]]
    assert_equal expected_sub, @board.valid_ship_coordinates(@sub)
    assert_equal expected_cruiser, @board.valid_ship_coordinates(@cruiser)
  end
end
