require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

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

  def test_the_render_of_cell
    cell_1 = Cell.new("B4")
    assert_equal ".", cell_1.render

    cell_1.fire_upon
    assert_equal "M", cell_1.render

    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)

    cell_2.fire_upon
    assert_equal "H", cell_2.render
    assert_equal false, cruiser.sunk?

    cruiser.hit
    cruiser.hit
    assert_equal true, cruiser.sunk?
    assert_equal "X", cell_2.render
  end
end
