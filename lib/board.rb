# Create Functionality for the Board Class


require 'pry'

require './lib/ship'



class Board

  attr_reader :size, :positions

  def initialize(size = 4)
    @size = size
    @positions = {}
    # example: positions[:A1][:enemy_map] => {shot: false, hit: false, boat: nil}
    # example: positions[:A1][:player_map] => {shot: false, hit: false, boat: nil}
  end


  # --- Build Board ---

  def rows
    
  end

  def columns
  end

  def create_positions
  end

  def assign_positions
  end

  def initialize_positions
  end
  # -------------------------------------------
  # at each position
  # maps{
  #   player_map: {shot: false, hit: false, boat: nil},
  #   enemy_map: {shot: false, hit: false, boat: nil}
  # }
  # ---------------------------------------------

  def update_positions
  end


  # --- Place Boats ---



  # --- Print Board ---



  # --- Assess Progress ---









end
