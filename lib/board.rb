require './lib/cell'

class Board
  attr_reader :cells
  def initialize
    @cells = {A1: Cell.new("A1"),
              A2: Cell.new("A2"),
              A3: Cell.new("A3"),
              A4: Cell.new("A4"),
              B1: Cell.new("B1"),
              B2: Cell.new("B2"),
              B3: Cell.new("B3"),
              B4: Cell.new("B4"),
              C1: Cell.new("C1"),
              C2: Cell.new("C2"),
              C3: Cell.new("C3"),
              C4: Cell.new("C4"),
              D1: Cell.new("D1"),
              D2: Cell.new("D2"),
              D3: Cell.new("D3"),
              D4: Cell.new("D4")
            }
  end
  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate.to_sym)
  end

  def valid_placement?(ship, coordinates)
    valid_length = placement_coordinates_equals_ship_length?(ship, coordinates)
    consecutive = placement_coordinates_consecutive?(ship, coordinates)
    overlaping_ships = check_for_overlaping_ships(coordinates)
    valid_length == true && consecutive == true && overlaping_ships == true
  end

  def check_for_overlaping_ships(coordinates)
    coordinates.each do |coordinate|
      if @cells[coordinate.to_sym].empty? == false
        return false
      end
    end
    true
  end

  def placement_coordinates_equals_ship_length?(ship, coordinates)
    ship.length == coordinates.count
  end

  def placement_coordinates_consecutive?(ship, coordinates)
    letters = []
    numbers = []
    coordinates.map do |coordinate|
      letters << coordinate[0]
      numbers << coordinate[1]
    end
    if letters.uniq.length == 1 && numbers.uniq.length == ship.length
      first_number = numbers.sort[0]
      last_number = numbers.sort[-1]
      range = (first_number .. last_number).to_a
      range.length == ship.length
    elsif numbers.uniq.length == 1 && letters.uniq.length == ship.length
      first_letter = letters.sort[0]
      last_letter = letters.sort[-1]
      range = (first_letter .. last_letter).to_a
      range.length == ship.length
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.map do |coordinate|
        @cells[coordinate.to_sym].place_ship(ship)
      end
    end
  end

end
