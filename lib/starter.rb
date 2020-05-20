class Starter
  attr_reader :cpu_board,
              :player_board,
              :placement_1,
              :placement_2,
              :cpu_ship_1,
              :cpu_ship_2,
              :player_ship_1,
              :player_ship_2

  def initialize(cpu_board, player_board)
    @cpu_board = cpu_board
    @player_board = player_board
    @placement_1 = nil
    @placement_2 = nil
    @cpu_ship_1 = nil
    @cpu_ship_2 = nil
    @player_ship_1 = nil
    @player_ship_2 = nil
    @valid_player_cells = nil
    @valid_cells = nil
  end

  def user_input
    gets.chomp
  end

  def start
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    start_game = user_input.downcase

    if start_game == "p"
      play_game
    elsif start_game == "c"
      puts "custom game coming soon!"
    elsif start_game == "q"
      puts "game over!"
    end
  end

  def play_game
    create_ship_1("Cruiser", 3)
    create_ship_2("Sub", 2)
    calibrate_board_for_ships(@cpu_ship_1.length, @cpu_ship_2.length)
    create_valid_cells
    cpu_first_placement(@cpu_ship_1, @cpu_ship_1.length)
    cpu_second_placement(@cpu_ship_2, @cpu_ship_2.length)
    initial_game_instructions
    player_first_placement(@player_ship_1)
    second_placement_instructions
    player_second_placement(@player_ship_2)
    puts "LET'S PLAY!!!"
    turn
  end

  def create_ship_1(name, length)
    @player_ship_1 = Ship.new("#{name.capitalize}", length)
    @cpu_ship_1 = Ship.new("#{name.capitalize}", length)
  end

  def create_ship_2(name, length)
    @player_ship_2 = Ship.new("#{name.capitalize}", length)
    @cpu_ship_2 = Ship.new("#{name.capitalize}", length)
  end

  def calibrate_board_for_ships(length_1, length_2)
    @cpu_board.ship_coordinates(length_1)
    @cpu_board.ship_coordinates(length_2)
    @player_board.ship_coordinates(length_1)
    @player_board.ship_coordinates(length_2)
  end

  def create_valid_cells
    @valid_player_cells = @player_board.valid_ship_coordinates.flatten.uniq!
    @valid_cells = @cpu_board.valid_ship_coordinates.flatten.uniq!
  end

  def cpu_first_placement(ship, length)
    first_placement = @cpu_board.valid_ship_coordinates.select do |array|
      array.count == length
    end
    @placement_1 = first_placement.sample(1).flatten!
    @cpu_board.place(ship, @placement_1)
  end

  def cpu_second_placement(ship, length)
    second_placement = @cpu_board.valid_ship_coordinates.select do |array|
      array.count == length
    end
    @placement_2  = second_placement.select do |array|
      @cpu_board.cells[array[0]].empty? && @cpu_board.cells[array[1]].empty?
    end.sample(1).flatten!
    @cpu_board.place(ship, @placement_2)
  end

  def initial_game_instructions
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    puts "Please select consececutive spaces for placement. (e.g. A1 A2 A3 OR A1 B1 C1)"
    puts "Enter the spaces for the Cruiser (3 spaces):"
    print "=> "
  end

  def player_first_placement(ship)
    first_placement = user_input.upcase.split(" ")
    until @player_board.valid_placement?(ship, first_placement) do
      puts "Those are invalid coordinates. Please try again:"
      print "=> "
      first_placement = user_input.upcase.split(" ")
    end
    if @player_board.valid_placement?(ship, first_placement)
      @player_board.place(ship, first_placement)
      puts @player_board.render(true)
    end
  end

  def second_placement_instructions
    puts "Enter the spaces for the Submarine (2 spaces):"
    print "=> "
  end

  def player_second_placement(ship)
    second_placement = user_input.upcase.split(" ")
    until @player_board.valid_placement?(ship, second_placement) do
      puts "Those are invalid coordinates. Please try again:"
      print "=> "
      second_placement = user_input.upcase.split(" ")
    end
    if @player_board.valid_placement?(ship, second_placement)
      @player_board.place(ship, second_placement)
      puts @player_board.render(true)
    end
  end

  def print_boards
    puts "=============COMPUTER BOARD============="
    puts @cpu_board.render
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
  end

  def player_shot
    print "Enter the coordinate for your shot: "
    player_shot = user_input.upcase
    until @valid_cells.include?(player_shot) do
      puts "Please enter a valid coordinate: "
      player_shot = user_input.upcase
    end
    if @valid_cells.include?(player_shot)
      if @cpu_board.cells[player_shot].fired_upon?
        puts "Already fired upon this space. Lose a turn."
      else
        @cpu_board.cells[player_shot].fire_upon
        if @cpu_board.cells[player_shot].render == "X"
          puts "Your shot on #{player_shot} was a hit. Ship sunk."
        elsif @cpu_board.cells[player_shot].render == "H"
          puts "Your shot on #{player_shot} was a hit"
        else
          puts "Your shot on #{player_shot} was a miss."
        end
      end
    end
  end

  def cpu_shot
    shot = @valid_player_cells.sample(1).shift
    @valid_player_cells.delete(shot)
    @player_board.cells[shot].fire_upon
    if @player_board.cells[shot].render == "X"
      puts "My shot on #{shot} was a hit. Ship sunk."
    elsif @player_board.cells[shot].render == "H"
      puts "My shot on #{shot} was a hit."
    else
      puts "My shot on #{shot} was a miss."
    end
  end

  def turn
    until game_over? do
      print_boards
      player_shot
      if game_over? && player_wins
        print_boards
        puts "You won!"
        break
      end
      cpu_shot
      if game_over? && cpu_wins
        print_boards
        puts "I won!"
        break
      end
    end
  end

  def player_wins
    @cpu_ship_1.health == 0 && @cpu_ship_2.health == 0
  end

  def cpu_wins
    @player_ship_1.health == 0 && @player_ship_2.health == 0
  end

  def game_over?
    player_wins || cpu_wins
  end
end
