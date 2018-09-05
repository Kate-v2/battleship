require 'pry'

require './lib/board'
require './lib/ship'


class Player
  attr_reader :is_human, :board

  def initialize(human)
    @is_human = human
    @board = Board.new
  end


  # --- Ship Placement ---

  def process_coordinates(string)
    [ string[0..1], string[3..4] ]
  end








  # --- Ship Placement Validation ---

  def validate_ship_placement(string, size)
    pick_random if string == "random"
    form = assess_format(string)
    grid = assess_diagonal(string)
    space = assess_spacing(string, size)
    possible = assess_as_possible(string)
    return true if form && grid && space && possible
    # repromt
  end

  def assess_format(string)
    case1 = string.size == 5
    arr = @board.create_positions
    case2 = string[0,1] != string[4,5]
    case3 = arr.include?(string[0..1])
    case4 = arr.include?(string[3..4])
    # binding.pry
    return true if case1 && case2 && case3 && case4
    p "Check your format!\nsize 2: A1 A2\nsize 3: A1 A3"
    return false
  end

  def assess_diagonal(string)
    arr = process_coordinates(string)
    row_1 = arr[0][0]; column_1 = arr[0][1]
    row_2 = arr[1][0]; column_2 = arr[1][1]
    case1 = row_1 == row_2
    case2 = column_1 == column_2
    return true if case1 || case2
    p "You can't place a boat diagonally."
    return false
  end
  # THESE TWO METHODS CAN BE COMBINED (diagonal & spacing)
  def assess_spacing(string, size)
    arr = process_coordinates(string).join.chars
    columns = (arr[1]..arr[3]).to_a.size
    rows = (arr[0]..arr[2]).to_a.size
    case1 = columns == size && rows == 1
    case2 = rows == size && columns == 1
    return true if case1 || case2
    p "You're placing a boat with #{size} anchors"
    return false
  end

# === COME BACK TO =====================================
  def assess_as_possible(string)
    arr = process_coordinates(string)
    possible = @board.possible_positions
    possible.find {|set| set.first == arr.first && set.last == arr.last}
  end
# === make board method =====================================
# TAKE CARE OF OVERLAP VALIDATION via possible_positions



end


  # def place_ships(sizes = [2, 3])
  #   sizes.each { |size| place_ship(size) }
  # end


  # def place_ship(size)
  #   # call for valid spots(3)
  #   # if computer, shuffle & pick
  #   # else compare input
  #     # reject with message
  #   # create new ship
  #   all = board.valid_for_ship(size)
  #   choice = @is_human ? pick(all) : pick_random(all)
  # end

  # def retrieve_valid_spots(size)
  # end
  #
  # def pick(choices)
  #   understand_input(string, choices)
  # end
  #
  # def understand_input(string, choices)
  #   if string == "random"
  #     pick_random(choices)
  #   # elsif
  #   # TYPES OF VALIDATION
  # end


  # --- Ship Placement Validation ---

  # def
  # end











  # --- Shooting validation ---


  # --- (PC) Random Shot ---


  # --- Human Shot ---
