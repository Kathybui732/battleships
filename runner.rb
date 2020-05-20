require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/starter'
require 'pry'

player_board = Board.new
cpu_board = Board.new
battleship = Starter.new(cpu_board, player_board)

battleship.start
