# a = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"], ["A4", "B4", "C4"], ["B1", "C1", "D1"], ["B2", "C2", "D2"], ["B3", "C3", "D3"], ["B4", "C4", "D4"], ["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["A2", "B2"], ["A3", "B3"], ["A4", "B4"], ["B1", "C1"], ["B2", "C2"], ["B3", "C3"], ["B4", "C4"], ["C1", "D1"], ["C2", "D2"], ["C3", "D3"], ["C4", "D4"]]
#
#
# coords = ["A1", "A2", "A3"]
# b = a.map do |array|
#   array.reject do |element|
#     element.include?(coords[0]) || element.include?(coords[1]) || element.include?(coords[2])
#   end
# end
#
# c = b.select do |array|
#   array.count == 2
# end
# #
# # b = a.select do |array|
# #   array.count == 3
# # end
#
# p c
# p c.sample(1)

# def create_board(size)
#   @cpu_board = Board.new(size)
#   @player_board = Board.new(size)
#
#   create_cells(size)
# end
#
# def create_cells(size)
#   letter_ord = (64 + size).chr
#   letters = ("A"..letter_ord).to_a
#   numbers = ("1"..size.to_s).to_a
#   custom_cell = letters.product(numbers).map { |x, y| x+y }
#
#   @cells = Hash.new
#
#   custom_cell.map do |cell|
#     @cells[cell] = Cell.new(cell)
#   end
# end

# hash = Hash.new
#
# hash["item_1"] = 1
#
# p hash
#
# def user_input
#   gets.chomp.downcase
# end
#
# def render(show_ship = false)
#   if show_ship == true
#     "  1 2 3 4 \n" +
#     "A #{cells["A1"].render(true)} #{cells["A2"].render(true)} #{cells["A3"].render(true)} #{cells["A4"].render(true)} \n" +
#     "B #{cells["B1"].render(true)} #{cells["B2"].render(true)} #{cells["B3"].render(true)} #{cells["B4"].render(true)} \n" +
#     "C #{cells["C1"].render(true)} #{cells["C2"].render(true)} #{cells["C3"].render(true)} #{cells["C4"].render(true)} \n" +
#     "D #{cells["D1"].render(true)} #{cells["D2"].render(true)} #{cells["D3"].render(true)} #{cells["D4"].render(true)} \n"
#
#   else
#     "  1 2 3 4 \n" +
#     "A #{cells["A1"].render} #{cells["A2"].render} #{cells["A3"].render} #{cells["A4"].render} \n" +
#     "B #{cells["B1"].render} #{cells["B2"].render} #{cells["B3"].render} #{cells["B4"].render} \n" +
#     "C #{cells["C1"].render} #{cells["C2"].render} #{cells["C3"].render} #{cells["C4"].render} \n" +
#     "D #{cells["D1"].render} #{cells["D2"].render} #{cells["D3"].render} #{cells["D4"].render} \n"
#   end
# end

cells = {
  "A1" => "cellA1",
  "A2" => "cellA2",
  "A3" => "cellA3",
  "A4" => "cellA4",
  "B1" => "cellB1",
  "B2" => "cellB2",
  "B3" => "cellB3",
  "B4" => "cellB4",
  "C1" => "cellC1",
  "C2" => "cellC2",
  "C3" => "cellC3",
  "C4" => "cellC4",
  "D1" => "cellD1",
  "D2" => "cellD2",
  "D3" => "cellD3",
  "D4" => "cellD4"
}

size = 5
letter_ord = (64 + size).chr
letters = ("A"..letter_ord).to_a
numbers_1 = ("1"..size.to_s).to_a
numbers = ("1"..size.to_s).to_a.unshift("  ").push("\n").join(" ")
custom_cell = letters.product(numbers_1).map { |x, y| x+y }


first_line = custom_cell.reduce("") do |acc, cell|
  acc.concat("#{cells[cell]} ")
  acc
end
puts numbers

puts first_line
