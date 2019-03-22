require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class Game

  def initialize
    @board = Board.new
    @ships = {
      crusier: Ship.new("Crusier", 3),
      submarine: Ship.new("Submarine", 2)
    }
  end

  def start
    main_menu
    setup_game
    #start_turns
    end_game
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
    @ships.each do |ship|
      possible_coordinates = []
      possible_left = []
      possible_right = []
      possible_up = []
      possible_down = []

      remaining_cells = @board.cells.select { |key, hash| hash.ship == nil }
      selected_cell = remaining_cells.to_a.sample
      i = 0
      while i < ship[1].length do
        #right
        letter = selected_cell[0][0]
        number = selected_cell[0][1].to_i + i
        if @board.valid_coordinate?(letter + number.to_s)
          possible_right << letter + number.to_s
        end
        i += 1
      end
      i = 0
      while i < ship[1].length do
        #left
        letter = selected_cell[0][0]
        number = selected_cell[0][1].to_i - i
        if @board.valid_coordinate?(letter + number.to_s)
          possible_left << letter + number.to_s
        end
        i += 1
      end
      i = 0
      while i < ship[1].length do
        #up
        letter = selected_cell[0][0].ord + i
        number = selected_cell[0][1]
        if @board.valid_coordinate?(letter.chr + number)
          possible_up << letter.chr + number
        end
        i += 1
      end
      i = 0
      while i < ship[1].length do
        #down
        letter = selected_cell[0][0].ord - i
        number = selected_cell[0][1]
        if @board.valid_coordinate?(letter.chr + number)
          possible_down << letter.chr + number
        end
        i += 1
      end
      possible_coordinates = [possible_right, possible_left, possible_up, possible_down]
      ship_placed = false
      # try to place the ship with possible_coordinates
      while ship_placed == false
        try_coordinates = possible_coordinates.shuffle.pop
        if @board.valid_placement?(ship[1], try_coordinates) == true
          @board.place(ship[1], try_coordinates)
          ship_placed = true
        end
      end
    end

    puts @board.render(true)

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
    puts "\nplayer place your ships."
    print "Location: "
    user_input = gets
  end

  def start_turns
    turns_display_boards
    turns_player_shot
    turns_computer_shot
    turns_results
  end

  def end_game
    #this method will end the game
    "You won!"
    "I won!"
  end

end
