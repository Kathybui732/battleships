require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/starter'
require './lib/custom_game'
require 'pry'

player_board = Board.new
cpu_board = Board.new
battleship = Starter.new(cpu_board, player_board)
custom_game = CustomGame.new

battleship.start
# custom_game.start
