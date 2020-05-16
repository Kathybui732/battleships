require "pry"
require "./lib/cell"

class Board
  attr_reader :cells, :ship_length, :input_coords
  def initialize(board_size = 4)
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4"),
    }
    @board_size = board_size
    @ship_length = nil
    @input_coords = nil
    @valid_number_coordinates = []
    @valid_letter_coordinates = []
    @valid_ship_coordinates = []
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    @ship_length = ship.length
    @input_coords = coordinates

    is_valid = @valid_ship_coordinates.any? do |coords|
      coords == @input_coords
    end

    coordinates.length == ship.length && is_valid
  end

  def number_coordinates
    coordinates = []
    (1..@board_size).each_cons(@ship_length)do |array|
      coordinates << array
    end
    coordinates.each do |array|
      @valid_number_coordinates << array.map do |number|
        number.to_s
      end
    end
    @valid_number_coordinates
  end

  def letter_coordinates
    letter_ord = (64 + @board_size).chr
    ("A"..letter_ord).each_cons(@ship_length) do |letter|
      @valid_letter_coordinates << letter
    end
    @valid_letter_coordinates
  end

  def ship_coordinates
    letter_ord = (64 + @board_size).chr
    letters = ("A"..letter_ord).to_a.zip
    numbers = ("1"..@board_size.to_s).to_a.zip
    letters.each do |letter|
      @valid_number_coordinates.each do |array|
        @valid_ship_coordinates << letter.product(array).collect { |x,y| x + y }
      end
    end
    @valid_letter_coordinates.each do |array|
      numbers.each do |number|
        @valid_ship_coordinates << array.product(number).collect { |x,y| x + y }
      end
    end
    return @valid_ship_coordinates
  end

  def place(ship, coordinates)
    coordinates.each do |cell|
      cell.place_ship(ship)
    end
  end
end
