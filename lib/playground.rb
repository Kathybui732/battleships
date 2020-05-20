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

# until player'shot is valid do
#   puts to tell them to choose another
#   gets.chomp
#   if plasyer's shot == valid
      # && if it has been fired upon
      # you lose your shot
      #else if valid
        #hit
        #miss
        #sunk
array = [["A1", "A2", "A3"], ["A2", "A3", "A4"], ["B1", "B2", "B3"], ["B2", "B3", "B4"], ["C1", "C2", "C3"], ["C2", "C3", "C4"], ["D1", "D2", "D3"], ["D2", "D3", "D4"], ["A1", "B1", "C1"], ["A2", "B2", "C2"], ["A3", "B3", "C3"], ["A4", "B4", "C4"], ["B1", "C1", "D1"], ["B2", "C2", "D2"], ["B3", "C3", "D3"], ["B4", "C4", "D4"], ["A1", "A2"], ["A2", "A3"], ["A3", "A4"], ["B1", "B2"], ["B2", "B3"], ["B3", "B4"], ["C1", "C2"], ["C2", "C3"], ["C3", "C4"], ["D1", "D2"], ["D2", "D3"], ["D3", "D4"], ["A1", "B1"], ["A2", "B2"], ["A3", "B3"], ["A4", "B4"], ["B1", "C1"], ["B2", "C2"], ["B3", "C3"], ["B4", "C4"], ["C1", "D1"], ["C2", "D2"], ["C3", "D3"], ["C4", "D4"]]

new_array = array.select do |array|
  array.length == 3
end

p new_array
placement_1 = new_array.sample(1).flatten!
puts placement_1

new_array_2 = array.select do |array|
  array.length == 2 &&
end

#
# def cpu_first_placement(length)
#   first_placement = array.select do |array|
#     array.count == length
#   end
#   placement_1 = first_placement.sample(1).flatten!
#   puts placement_1
#   def cpu_second_placement
#     second_placement = array.map do |array|
#       array.reject do |element|
#         element.include?(placement_1[0]) || element.include?(placement_1[1]) || element.include?(placement_1[2])
#       end
#     end
#     placement_2 = second_placement.select do |coords|
#       coords.count == 2
#     end.sample(1).flatten!
#   end
#   puts placement_2
# end
#
# cpu_first_placement(3)

new_array = second_placement = @cpu_board.valid_ship_coordinates.select do |array|
  array.length == 2
end

placement_2 =

cells[second_placement[0]].empty?

def cpu_second_placement(ship, length)
  second_placement = @cpu_board.valid_ship_coordinates.select do |coords|
    coords.count == length
  end
  second_placement.map do |array|
    array.reject do |element|
      element.include?(@placement_1[0]) || element.include?(@placement_1[1]) || element.include?(@placement_1[2])
    end
  end
  @placement_2 = second_placement.select do |array|
    array.length == 2
  end.sample(1).flatten!
  @cpu_board.place(ship, @placement_2)
end

def cpu_second_placement(ship, length)
  @placement_2 = second_placement.select do |coords|
    coords.count == length
  end.sample(1).flatten!
  second_placement = @cpu_board.valid_ship_coordinates.map do |array|
    array.reject do |element|
      element.include?(@placement_1[0]) || element.include?(@placement_1[1]) || element.include?(@placement_1[2])
    end
  end
  @cpu_board.place(ship, @placement_2)
end
