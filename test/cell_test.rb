require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require 'pry'

class CellTest < Minitest::Test

  def test_it_exist
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_has_coordinates
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
  end

  def test_ship_is_nil
    cell = Cell.new("B4")

    assert_nil cell.ship
  end

  def test_cell_is_empty
    cell = Cell.new("B4")

    assert_equal true, cell.empty?
  end

  def test_place_ship
    cell = Cell.new("B4")
    crusier = Ship.new("Crusier", 3)
    assert_equal true, cell.empty?
    cell.place_ship(crusier)

    assert_equal crusier, cell.ship
    assert_equal false, cell.empty?
  end
  def test_fire_upon
    cell = Cell.new("B4")
    crusier = Ship.new("Crusier", 3)
    cell.place_ship(crusier)
    assert_equal false, cell.fire_upon?
    cell.fire_upon
    assert_equal true, cell.fire_upon?
    assert_equal 2, cell.ship.health

  end

end
