# Create Functionality for the Board Class


require 'pry'

require './lib/ship'



class Board

  attr_reader :size, :positions

  def initialize(size = 4)
    @size = size
    @positions = {}
    # example: positions[:A1][:enemy_map] => {shot: false, hit: false, ship: nil}
    # example: positions[:A1][:player_map] => {shot: false, hit: false, ship: nil}
  end


  # --- Build Board ---
  # board is size dynamic!

  def rows
    alpha = ('A'..'Z').to_a
    alpha.first(@size)
  end

  def columns
    (1..@size).to_a
  end

  def create_positions
    self.columns.map { |num|
      self.rows.map { |char| [char, num].join }
    }.flatten.sort
  end
  # LATER --- for printing use .each_slice(@size)

  def initialize_positions
    create_positions.each {|pos|
      key = pos.to_sym
      # MUST BREAK THIS INTO MORE METHODS
      # CANNOT initialize a new hash within the hash before a nested hash is established
      @positions[key][:player_map] = {shot: false, hit: false, ship: nil}
      @positions[key][:enemy_map] = {shot: false, hit: false, ship: nil}
    }
  end
  # TO DO - SHIP & HIT are redundant, especially for enemy_map
      # HIT is stored in the ship

  def position_ships
    # ship holds coordnates
  end

  def update_player_map(coord)
    position = @positions[coord.to_sym][:player_map]
    position[:shot] = true
    if position[:ship] == true
      position[:hit] = true
      position[:ship].update_status(coord)
    end
  end

#  == FIX THIS ==============================================
  def update_enemy_map(coord)
    position = @positions[coord.to_sym][:enemy_map]
    position[:shot] = true
# TO DO --- ADD successful_hit method
      # player or board???
    if successful_hit
      position[:hit] = true
      position[:ship] = true
    end
  end
#  ==========================================================




  # --- Place Boats ---



  # --- Print Board ---



  # --- Assess Progress ---









end
