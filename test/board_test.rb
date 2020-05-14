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
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
    refute @board.valid_coordinate?("A5")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end

  def test_it_has_valid_coordinate_length
    binding.pry
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@sub, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@cruiser, ["A2", "A3", "A4"])
    assert_equal true, @board.valid_placement?(@sub, ["A2", "A3"])
  end

  def test_valid_placement_is_consecutive
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@sub, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@sub, ["C1", "B1"])
    assert_equal true, @board.valid_placement?(@sub, ["A1", "B1"])
    assert_equal true, @board.valid_placement?(@cruiser, ["C1", "C2", "C3"])
  end
end
