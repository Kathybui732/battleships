require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/starter'
require 'pry'

player_board = Board.new
cpu_board = Board.new
battleship = Starter.new(cpu_board, player_board)
cruiser = Ship.new("cru", 3)
sub = Ship.new("sub", 2)

battleship.start
#
  # battleship.calibrate_board_for_ships(3, 2)
  # battleship.cpu_first_placement(cruiser, 3)
  # battleship.cpu_first_placement(sub, 2)
  # puts "I have laid out my ships on the grid."
  # puts "You now need to lay out your two ships."
  # puts "The Cruiser is three units long and the Submarine is two units long."
  # puts "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
  # puts "Please select consececutive spaces for placement. (e.g. A1 A2 A3 OR A1 B1 C1)"
  # puts "Enter the spaces for the Cruiser (3 spaces):"
  # print "=> "
  # cruiser_placement = gets.chomp.upcase.split(" ")
  #
  # until battleship.player_board.valid_placement?(cruiser, cruiser_placement) do
  #   puts "Those are invalid coordinates. Please try again:"
  #   print "=> "
  #   cruiser_placement = gets.chomp.upcase.split(" ")
  # end
  # if battleship.player_board.valid_placement?(cruiser, cruiser_placement)
  #   battleship.player_board.place(cruiser, cruiser_placement)
  #   puts battleship.player_board.render(true)
  # end
  #
  # puts "Enter the spaces for the Submarine (2 spaces):"
  # print "=> "
  # sub_placement = gets.chomp.upcase.split(" ")
  #
  # until battleship.player_board.valid_placement?(sub, sub_placement) do
  #   puts "Those are invalid coordinates. Please try again:"
  #   print "=> "
  #   sub_placement = gets.chomp.upcase.split(" ")
  # end
  # if battleship.player_board.valid_placement?(sub, sub_placement)
  #   battleship.player_board.place(sub, sub_placement)
  #   puts battleship.player_board.render(true)
  # end

#   puts "Let's begin!"
#   puts "GOOD LUCK!"
# elsif start_game == "q"
#   puts "game over!
