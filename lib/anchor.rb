#  Create class for ship placement functionality

require 'pry'

require './lib/board'
require './lib/player'
require './lib/ship'


# AIM to have class methods!

class Anchor

  def assess_player(player)
    if player.is_human == false
      computer_place_ships(player.ships, player.board)
    else
      place_ships(player.ships, player.board)
    end
  end


# --- Place Ships ----

  def place_ships(ships, board)
    ships.each { |size|
      string = validate(size, board)
      coord = find_coordinate(string, board, size)
      place_ship(coord, board)
    }
  end

  def place_ship(coord, board)
    ship = Ship.new(coord)
    coord.each {|spot|
      key = spot.to_sym
      board.positions[key][:player_map][:ship] = ship
    }
  end
  # TO DO - remove anchor_ship from Board

  def computer_place_ships(ships, board)  # doesn't require input validation
    ships.each { |size|
      coordnates = board.possible_positions(size).shuffle!.pop
      place_ship(coordnates, board)
    }
    pass_turn
  end
  # TO DO - remove computer_place_ships from player

  def pass_turn
    puts "I have laid out my ships on the grid."
    puts "You now need to layout your two ships."
    puts "The first is two units long and the"
    puts "second is three units long."
    puts "The grid has A1 at the top left and D4 at the bottom right."
    puts ""
    return true
  end
    # TO DO - delete pass_turn from player




# --- General Methods ---


  def process_coordinates(string)
    [string[0..1], string[3..4]]
  end
  # TO DO - delete from player

  def find_coordinate(string, board, width)
    arr = board.possible_positions(width)
    spaces = process_coordinates(string)
    spots = arr.find { |set|
      spaces.first == set.first && spaces.last == set.last
    }.to_a
    return spots
  end


# --- Validation & Prompt ---


  def validate(width, board)
    string = prompt_user(width)
    return string if find_coordinate(string, board, width)
    validate(width, board) if assess_format(string, board, width) == false
    validate(width, board) if assess_spacing(string, width) == false
    validate(width, board) if assess_diagonal(string) == false
  end

  def prompt_user(width)
    if width == 2
      p "Enter the squares for the two-unit ship: "
      string = $stdin.gets.chomp
    else
      p "Enter the squares for the three-unit ship: "
      string = $stdin.gets.chomp
    end
    return string
  end

  def assess_format(string, board, width)
    case1 = string.size == 5
    case2 = string[0,1] != string[4,5]
    case3 = find_coordinate(string, board, width)
    return true if case1 && case2 && case3 #&& case4
    puts "Check your format!\nsize 2: A1 A2\nsize 3: A1 A3"
    return false
  end

  def assess_diagonal(string)
    arr = process_coordinates(string)
    row_1 = arr[0][0]; column_1 = arr[0][1]
    row_2 = arr[1][0]; column_2 = arr[1][1]
    case1 = row_1 == row_2
    case2 = column_1 == column_2
    return true if case1 || case2
    puts "You can't place a boat diagonally."
    return false
  end

  def assess_spacing(string, width)
    arr = process_coordinates(string).join.chars
    columns = (arr[1]..arr[3]).to_a.count
    rows = (arr[0]..arr[2]).to_a.count
    case1 = columns == width && rows == 1
    case2 = rows == width && columns == 1
    return true if case1 || case2
    puts "You're placing a boat with #{width} anchors"
    return false
  end

end
