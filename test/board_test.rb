require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new
    assert_instance_of Board, board
  end
  def test_board_cells_initiates_with_empty_cells_hash
    board = Board.new
    assert_equal 0, board.cells.count
    assert_equal Hash, board.cells.class
  end
  def test_valid_coordinate
    board = Board.new
    board.create_cells(4)
    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end
  def test_valid_placement_of_ships
    board = Board.new
    board.create_cells(4)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal true, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal true, board.valid_placement?(submarine, ["C1", "B1"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_placing_a_ship_on_board_where_cells_contain_ships
    board = Board.new
    board.create_cells(4)
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1","A2", "A3"])
    cell_1 = board.cells[:A1]
    cell_2 = board.cells[:A2]
    cell_3 = board.cells[:A3]

    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
    assert_equal true, cell_3.ship == cell_2.ship
    assert_equal true, cell_1.ship == cell_2.ship
  end
  def test_for_overlaping_ships
    board = Board.new
    board.create_cells(4)
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1","A2", "A3"])
    submarine = Ship.new("Submarine", 2)
    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
    assert_equal true, board.valid_placement?(submarine, ["B1", "B2"])
  end

  def test_does_it_create_cells
    board = Board.new
    board.create_cells(5)

    assert_equal 25, board.cells.count
  end
end
