class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @has_it_been_fired = false
  end

  def empty?
    if @ship == nil
      true
    else
      false
    end
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon?
    @has_it_been_fired
  end

  def fire_upon
    if @ship != nil
      @ship.hit
    end
    @has_it_been_fired = true
  end

  def render(player = false)
    if player == true
      "S"
    elsif @ship == nil && @has_it_been_fired == true
      "M"
    elsif @ship != nil && @has_it_been_fired == true && @ship.sunk? == false
      "H"
    elsif @has_it_been_fired == true && @ship.sunk? == true
      "X"
    else
      "."
    end
  end
end
