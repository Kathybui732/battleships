require "pry"
require "./lib/cell"

class Board
  attr_reader :cells, :valid_ship_coordinates
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
    @input_coords = coordinates

    def input_coordinates_empty?
      @input_coords.all? do |coordinate|
        @cells[coordinate].empty?
      end
    end

    coordinates.length == ship.length && is_valid? && input_coordinates_empty?
  end

  def number_coordinates
    coordinates = []
    ("1"..@board_size.to_s).each_cons(@ship_length)do |array|
      @valid_number_coordinates << array
    end
    @valid_number_coordinates.uniq
  end

  def letter_coordinates
    letter_ord = (64 + @board_size).chr
    ("A"..letter_ord).each_cons(@ship_length) do |letter|
      @valid_letter_coordinates << letter
    end
    @valid_letter_coordinates.uniq
  end

  def ship_coordinates(length)
    @ship_length = length
    number_coordinates
    letter_coordinates
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
    return @valid_ship_coordinates.uniq
  end

  def place(ship, coordinates)
    coordinates.each do |cell|
      @cells[cell].place_ship(ship)
    end
  end

  def is_valid?
    @valid_ship_coordinates.any? do |coords|
      coords == @input_coords
    end
  end

  def render
    "  1 2 3 4 \n" +
    "A #{cells["A1"].render} #{cells["A2"].render} #{cells["A3"].render} #{cells["A4"].render} \n" +
    "B #{cells["B1"].render} #{cells["B2"].render} #{cells["B3"].render} #{cells["B4"].render} \n" +
    "C #{cells["C1"].render} #{cells["C2"].render} #{cells["C3"].render} #{cells["C4"].render} \n" +
    "D #{cells["D1"].render} #{cells["D2"].render} #{cells["D3"].render} #{cells["D4"].render} \n"
  end
end
