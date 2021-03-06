require './lib/ship'
require './lib/cell'
require './lib/board'

class Game

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @player_ships = {
      crusier: Ship.new("Crusier", 3),
      submarine: Ship.new("Submarine", 2)
    }
    @computer_ships = {
      crusier: Ship.new("Crusier", 3),
      submarine: Ship.new("Submarine", 2)
    }
  end

  def start
    main_menu
    setup_game
    start_turns
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
    setup_board_size
    setup_computer_place_ships
    setup_player_place_ships
  end

  def setup_board_size
    puts "Enter board size; number 4 through 10"
    input = gets.chomp.to_i
    if input >= 4 && input <= 10
      @player_board.create_cells(input)
      @computer_board.create_cells(input)
    else
      puts "Invalid input!"
      setup_board_size
    end
  end

  def setup_computer_place_ships
    # this method will execute the code for the computer to place ships.
    @computer_ships.each do |ship|
      possible_coordinates = []
      possible_left = []
      possible_right = []
      possible_up = []
      possible_down = []

      remaining_cells = @computer_board.cells.select { |key, hash| hash.ship == nil }
      selected_cell = remaining_cells.to_a.sample[0]
      i = 0
      while i < ship[1].length do
        #right
        letter = selected_cell[0]
        number = selected_cell[1].to_i + i
        if @computer_board.valid_coordinate?(letter + number.to_s)
          possible_right << letter + number.to_s
        end
        i += 1
      end
      i = 0
      while i < ship[1].length do
        #left
        letter = selected_cell[0]
        number = selected_cell[1].to_i - i
        if @computer_board.valid_coordinate?(letter + number.to_s)
          possible_left << letter + number.to_s
        end
        i += 1
      end
      i = 0
      while i < ship[1].length do
        #up
        letter = selected_cell[0].ord + i
        number = selected_cell[1]
        if @computer_board.valid_coordinate?(letter.chr + number)
          possible_up << letter.chr + number
        end
        i += 1
      end
      i = 0
      while i < ship[1].length do
        #down
        letter = selected_cell[0].ord - i
        number = selected_cell[1]
        if @computer_board.valid_coordinate?(letter.chr + number)
          possible_down << letter.chr + number
        end
        i += 1
      end
      possible_coordinates = [possible_right, possible_left, possible_up, possible_down]
      ship_placed = false
      # try to place the ship with possible_coordinates
      while ship_placed == false
        try_coordinates = possible_coordinates.shuffle.pop
        if @computer_board.valid_placement?(ship[1], try_coordinates) == true
          @computer_board.place(ship[1], try_coordinates)
          ship_placed = true
        end
      end
    end

    puts "Computer is placing ships!"
    sleep(1); print " ."
    sleep(0.5); print ".  "
    sleep(1.5); print "."
    sleep(0.5); print "."
    sleep(0.5); print "."
    sleep(1.5); print "  ."
    sleep(0.5); print ".  "
    sleep(1)
  end

  def setup_player_place_ships
    #this method will execute the code for the player to place ships.
    puts "\nI have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    @player_ships.each{|ship| puts "The #{ship[1].name} is #{ship[1].length}."}
    puts @player_board.render(true)
    puts "Enter the coordinates seperated by a space"
    @player_ships.each do |ship|
      ship_placed = false
      while ship_placed == false
        puts "Now placing the #{ship[1].name}, taking up #{ship[1].length}."
        print "Coordinates: "
        user_input = gets.chomp.upcase.split
        if user_input.length == ship[1].length
          if user_input.each{|coordinate| @player_board.valid_coordinate?(coordinate)}
            if @player_board.valid_placement?(ship[1], user_input)
              @player_board.place(ship[1], user_input)
              puts "#{ship[1].name} placed!"
              puts @player_board.render(true)
              ship_placed = true
            end
          end
        end
      end
    end
  end

  def start_turns
    turns_display_boards
    turns_player_take_a_shot
    turns_computer_take_a_shot
    turns_results_of_shots
  end

  def turns_display_boards
    10.times{puts " "}
    puts "Computer's Board\n"
    puts @computer_board.render()
    puts "\n\n Your Board\n"
    puts @player_board.render(true)
    puts " "
  end

  def turns_player_take_a_shot
    puts "Choose a coordinate to fire on"
    input = gets.chomp.upcase
    if @computer_board.valid_coordinate?(input) == true
      if@computer_board.cells[input.to_sym].fire_upon? == false
        @computer_board.cells[input.to_sym].fire_upon
        puts "Hit"
      else
        puts "This cell has been fire upon"
        turns_player_take_a_shot
      end
    else
      puts "This is not a valid coordinate"
      turns_player_take_a_shot
    end
  end
  def turns_computer_take_a_shot
    remaining_cells = @player_board.cells.select { |key, hash| hash.fire_upon? == false }
    selected_cell = remaining_cells.to_a.sample
    selected_cell[1].fire_upon
    puts turns_display_boards
  end

  def turns_results_of_shots
    status = game_over?
    if status == false
      start_turns
    end
  end

  def game_over?
    player_remaining_ships =   @player_ships.select{| key, ship| ship.sunk? == false }
    computer_remaining_ships = @computer_ships.select{|key, ship| ship.sunk? == false }
    if computer_remaining_ships.length < 1
      puts "Player wins!"
      return true
    elsif player_remaining_ships.length < 1
      puts "Computer wins!"
      return true
    end
    return false
  end
end
