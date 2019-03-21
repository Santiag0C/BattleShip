require './lib/ship'
require './lib/cell'
require './lib/board'

class Game

  def start
    main_menu
    puts "game has started!!!"
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

end
