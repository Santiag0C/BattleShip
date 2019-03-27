require './lib/cell'

class Board
  attr_reader :cells

  def initialize
    @cells = {}
  end

  def create_cells(number)
    characters = ("A" .. (64 + number).chr).to_a
    numbers = (1 .. number).to_a
    characters.each do |char|
      numbers.each do |num|
        @cells[("#{char}#{num}").to_sym] = Cell.new("#{char}#{num}")
      end
    end
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate.to_sym)
  end

  def valid_placement?(ship, coordinates)
    valid_length = placement_coordinates_equals_ship_length?(ship, coordinates)
    consecutive = placement_coordinates_consecutive?(ship, coordinates)
    overlaping_ships = check_for_overlaping_ships(coordinates)
    valid_length && consecutive && overlaping_ships
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
      range = (numbers.sort[0] .. numbers.sort[-1]).to_a
      return range.length == ship.length
    elsif numbers.uniq.length == 1 && letters.uniq.length == ship.length
      range = (letters.sort[0] .. letters.sort[-1]).to_a
      return range.length == ship.length
    end
    false
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.map do |coordinate|
        @cells[coordinate.to_sym].place_ship(ship)
      end
    end
  end

  def render(rend = false)
    number_of_columns = (1 .. Math.sqrt(@cells.length)).to_a
    rows = @cells.to_a.each_slice(number_of_columns.count)
    print " "; number_of_columns.each{|num| print " #{num}"}; print "\n"
    rows.each do |row|
      print row[0][0].to_s[0]
      row.each do |value|
        print " "
        print value[1].render(rend)
      end
      puts " "
    end
  end
end
