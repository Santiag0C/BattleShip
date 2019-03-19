class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship
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
    @has_it_been_fired = true
    @ship.hit
  end
end
