require "minitest/autorun"
require "minitest/pride"
require "./lib/board"
require "./lib/ship"
require "./lib/cell"
require "./lib/starter"
require "./lib/custom_game"
require "pry"

class CustomGameTest < Minitest::Test

  def setup
    @custom_game = CustomGame.new
  end

end
