require "minitest/autorun"
require "minitest/pride"
require "./lib/board"
require "./lib/ship"
require "./lib/cell"
require "pry"

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_board_has_cells
    assert_equal Hash, @board.cells.class
    assert_equal 16, @board.cells.count
  end
end
