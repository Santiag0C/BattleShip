require './lib/ship'
require './lib/cell'
require './lib/board'

class Game
  def initialize
   @board = Board.new
   @cruiser = Ship.new("Cruiser", 3)
   @submarine = Ship.new("Submarine", 2)
   @number_of_ships = 0
  end
  def start
    main_menu
    setup_game
    start_turns
    # end_game
  end

  def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp
    if input.upcase == "Q"
      exit
    elsif input.upcase != "P"
      puts "Invalid input!"
      main_menu
    end
  end

  def setup_game
    # This method will call the helper methods below to setup the game.
    setup_computer_place_ships
    setup_player_place_ships
  end

  def setup_computer_place_ships
    # this method will execute the code for the computer to place ships.
    remaining_cells = @board.cells.select { |key, hash| hash.ship == nil }
    selected_cell = remaining_cells.to_a[rand(0 .. remaining_cells.length)]
    selected_cell[1].coordinate
    bord_size = @board.cells.count/4

    ran_ship = rand(0..1)
    if ran_ship == 0
      ship = @cruiser
    else
      ship = @submarine
    end

    letters_abil = ("A".."Z").to_a[0..bord_size-1]
    let_num_last = letters_abil.last.ord
    let_num_first = letters_abil.first.ord
    numb_selected = selected_cell[1].coordinate[1].to_i
    leter_selected = selected_cell[1].coordinate[0]


    place_cord = []
    num = 1
    if num == 1 && numb_selected + (ship.length - 1) <= bord_size
      place_cord << selected_cell[1].coordinate
      while place_cord.count != ship.length
        numb_selected += 1
        place_cord << "#{leter_selected}#{numb_selected}"
        #right
      end
      if @board.valid_placement?(ship, place_cord) == true
        @board.place(ship, place_cord)
      end
    elsif num == 2 && leter_selected.ord + (ship.length - 1) <= let_num_last
      let_in_numb = leter_selected.ord
      place_cord << selected_cell[1].coordinate
      while place_cord.count != ship.length
        let_in_numb += 1
        place_cord << "#{let_in_numb.chr}#{numb_selected}"
        #down
      end
      if @board.valid_placement?(ship, place_cord) == true
        @board.place(ship, place_cord)
      end

    elsif num == 3 && numb_selected - (ship.length - 1) >= 1
      place_cord << selected_cell[1].coordinate
      while place_cord.count != ship.length
        numb_selected -= 1
        place_cord << "#{leter_selected}#{numb_selected}"
        #left
      end
      if @board.valid_placement?(ship, place_cord) == true
        @board.place(ship, place_cord)
        binding.pry
      end

    elsif num == 4 && leter_selected.ord - (ship.length - 1) >= let_num_first
      let_in_numb = leter_selected.ord
      place_cord << selected_cell[1].coordinate
      while place_cord.count != ship.length
        let_in_numb -= 1
        place_cord << "#{let_in_numb.chr}#{numb_selected}"
        #up
      end
      if @board.valid_placement?(ship, place_cord) == true
         @board.place(ship, place_cord)
      end
      else
        remaining_cells.delete(selected_cell[0])
      end
    end




  def setup_player_place_ships
    #this method will execute the code for the player to place ships.
    ran_ship = rand(0..1)
    if ran_ship == 0
      ship = @cruiser
    else
      ship = @submarine
    end

    @board.render(rend = false)
    puts "Place your you'r #{ship.name} (#{ship.health} spaces)"
    puts "Example (A1, b2, C3)"
    #input = gets.chomp
  end

  def start_turns
    #turns_display_boards
    # turns_player_shot
    # turns_computer_shot
    # turns_results
  end

  def end_game
    #this method will end the game
    "You won!"
    "I won!"
  end

end
