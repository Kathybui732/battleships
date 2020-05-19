require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require 'pry'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
    @cell_2 = Cell.new("C3")
  end

  def test_cell_exists
    assert_instance_of Cell, @cell
  end

  def test_it_has_a_coordinate
    assert_equal "B4", @cell.coordinate
  end

  def test_it_can_have_a_ship
    assert_nil nil, @cell.ship
  end

  def test_cell_is_empty
    assert_equal true, @cell.empty?
  end

  def test_it_can_place_ship
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
  end

  def test_is_it_fired_upon
    @cell.place_ship(@cruiser)
    assert_equal false, @cell.fired_upon?
  end

  def test_it_can_fire_upon
    @cell.place_ship(@cruiser)
    @cell.fire_upon
    assert_equal 2, @cell.ship.health
    assert_equal true, @cell.fired_upon?
  end

  def test_it_can_render
    assert_equal ".", @cell.render
  end

  def test_it_can_change_render_when_fire_upon
    @cell.fire_upon
    assert_equal "M", @cell.render
  end

  def test_it_can_place_another_ship
    @cell_2.place_ship(@cruiser)
    assert_equal ".", @cell_2.render
    assert_equal "S", @cell_2.render(true)
  end

  def test_it_sinks_after_3_fire_upons
    @cell_2.place_ship(@cruiser)
    @cell_2.fire_upon
    assert_equal "H", @cell_2.render
    assert_equal false, @cruiser.sunk?
    @cruiser.hit
    @cruiser.hit
    assert_equal true, @cruiser.sunk?
    assert_equal "X", @cell_2.render
  end
end
