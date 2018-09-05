require 'pry'

require './lib/board'
require './lib/ship'


class Player
  attr_reader :is_human, :board

  def initialize(human)
    @is_human = human
    @board = Board.new
  end


  # --- Ship Placement Validation ---

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
  # TO DO -- if 2nd position is "less than" first
  # is there a fuzzy match method?
  # if so, this doesn't matter

  # def assess_diagonal(input) # array
  #
  #   #  create array
  #   # assess
  #   # if valid = false
  #     #  print error message
  #   p "You can't place a boat diagonally."
  # end


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

  # def validate_ship_placement(string, choices, size)
  #   pick_random(choices) if string == "random"
  #   form = assess_format(string)
  #   # change format of input to array
  #   arr = process_coordinates(string)
  #   grid = assess_diagonal(arr)
  #   space = assess_spacing(arr, size)
  #   # =====================================
  #   # unique = assess_overlap()
  #   # =====================================
  #   form && grid && space && unique ? true : nil # repromt
  # end








  # def assess_spacing(input, size) # array & ship size
  #   # assess
  #   # if valid = false
  #     #  print error message
  #   p "You're placing a boat with #{size} anchors"
  # end


  # --- Shooting validation ---


  # --- (PC) Random Shot ---


  # --- Human Shot ---
