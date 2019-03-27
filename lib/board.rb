require './lib/cell'
require 'pry'
class Board
  attr_reader :cells
  def initialize
    @cells = {}
  end

  def create_cells(number)
    characters = ("A" .. ("A".ord + number - 1).chr).to_a
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
    valid_length == true && consecutive == true && overlaping_ships == true
  end
#helper
  def check_for_overlaping_ships(coordinates)
    coordinates.each do |coordinate|
      if @cells[coordinate.to_sym].empty? == false

        return false
      end
    end
    true
  end
#helper
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
#
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

    # "  1 2 3 4 \n" +
    # "A #{@cells[:A1].render(rend)} #{@cells[:A2].render(rend)} #{@cells[:A3].render(rend)} #{@cells[:A4].render(rend)} \n" +
    # "B #{@cells[:B1].render(rend)} #{@cells[:B2].render(rend)} #{@cells[:B3].render(rend)} #{@cells[:B4].render(rend)} \n" +
    # "C #{@cells[:C1].render(rend)} #{@cells[:C2].render(rend)} #{@cells[:C3].render(rend)} #{@cells[:C4].render(rend)} \n" +
    # "D #{@cells[:D1].render(rend)} #{@cells[:D2].render(rend)} #{@cells[:D3].render(rend)} #{@cells[:D4].render(rend)} \n"
  end
end
# array_of_arrays = [['a1','a2','a3'],['b1','b2','b3'],['c1','c2','c3']]
# array_of_arrays.each do |array|
#   print array[0][0]
#   array.each do |value|
#     print " "
#     print value
#   end
#   puts " "
# end
