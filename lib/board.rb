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
    if ship.length == coordinates.count
      letter = []
      number = []
      coordinates.each do |coordin|
        binding.pry
        letter << coordin[0]
        number << coordin[1]
          end
        letter.uniq!.sort!
        number.uniq!.sort!

        if letter.count == 1 && number.count == 3 && number.last < 5
          #then its horizontal and a crus
          if number.last - number.first == 2

        elsif letter.count == 1 && number.count == 2 && number.last < 5
          #this is horizontal and a sub
          if number.last - number.first == 1

        elsif letter.count == 3 && number.count == 1
          #is crus and vertical

        elsif letter.count == 2 && number.count == 1
          #is sub and vertical

        else
          "not valid"
      end
    end
  end
end
