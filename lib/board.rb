# Create Functionality for the Board Class


require 'pry'

require './lib/ship'
require './lib/player'



class Board

  attr_reader :size, :positions

  def initialize(size = 4)
    @size = size
    @positions = {}
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
      @positions[pos.to_sym] = {
        :player_map => {shot: false, hit: false, ship: nil},
        :enemy_map => {shot: false, hit: false} # implied by a hit - , ship: nil
      }
    }
  end
  # TO DO -  HIT is stored in the ships, should it stay in this hash

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

  def update_enemy_map(coord, success)
    # success is T/F
    position = @positions[coord.to_sym][:enemy_map]
    position[:shot] = true
    position[:hit] = true if success
  end
  # TO DO --- ADD successful_hit method
    # player or board???



  # --- Place Boats ---



  # --- Print Board ---



  # --- Assess Progress ---









end
