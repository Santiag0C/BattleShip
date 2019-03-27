require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test
  def test_it_exist
    cruiser = Ship.new("Cruiser", 3)
    assert_instance_of Ship,cruiser
  end

  def test_it_has_a_name
    cruiser = Ship.new("Cruiser", 3)
    assert_equal "Cruiser",cruiser.name
  end

  def test_it_has_a_length
    cruiser = Ship.new("Cruiser", 3)
    assert_equal 3,cruiser.length
  end

  def test_it_has_a_health
    cruiser = Ship.new("Cruiser", 3)
    assert_equal 3, cruiser.health
  end

  def test_if_it_sunk
    cruiser = Ship.new("Cruiser", 3)
    assert_equal false, cruiser.sunk?
  end

  def test_cruiser_got_hit
    cruiser = Ship.new("Cruiser", 3)
    cruiser.hit
    assert_equal 2, cruiser.health
    assert_equal false, cruiser.sunk?
    cruiser.hit
    assert_equal 1, cruiser.health
    assert_equal false, cruiser.sunk?
    cruiser.hit
    assert_equal 0, cruiser.health
    assert_equal true, cruiser.sunk?
  end
end
