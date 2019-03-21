require './lib/ship'
require './lib/cell'
require './lib/board'

class Game

  def start
    main_menu
    setup_game
    start_turns
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
    puts "Computer is placing ships!"
    sleep(1.5); print " .. "
    sleep(1); print " ... "
    sleep(1.5); print " .. "
  end

  def setup_player_place_ships
    #this method will execute the code for the player to place ships.
    puts "\nplayer place your ships."
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
