#main menu
require './lib/ship'
require './lib/cell'
require './lib/board'
puts "Welcome to BATTLESHIP"
puts "Enter p to play. Enter q to quit."
input = gets.chomp
board = Board.new
cruiser = Ship.new("Cruiser", 3)
cell = Cell.new("B4")
  if input == "p"
    board.place(cruiser, ["A1", "A2", "b3"])
    puts board.render(rend = true)




  elsif input == "q"
    puts ""
    puts "༼ つ ◕_◕ ༽つ"
    puts "       are you serious"
    puts ""

  end
