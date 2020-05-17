require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/starter'
require 'pry'
cruiser = Ship.new("Cruiser", 3)
sub = Ship.new("Sub", 2)
puts "Welcome to BATTLESHIP"
puts "Enter p to play. Enter q to quit."
start_game = gets.chomp.downcase

if start_game == p
  battleship = Starter.new
else
  "game over!"
end

puts "I have laid out my ships on the grid."
puts "You now need to lay out your two ships."
puts "The Cruiser is three units long and the Submarine is two units long."
puts "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
puts "Enter the squares for the Cruiser (3 spaces):"

print "=> "
cruiser_placement = gets.chomp.upcase.split(" ")
loop do
  battleship.player_board.valid_placement?
  "Those are invalid coordinates. Please try again:""
break if battleship.player_board.valid_placement?(cruiser, cruiser_placement)
  battleship.player_board.place_ship(cruiser, cruiser_placement)
