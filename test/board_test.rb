require_relative 'test_helper'

require './lib/board'
require './lib/ship'


class BoardTest < Minitest::Test

  def test_it_exists
    assert_instance_of Board, Board.new
  end

  def test_it_gets_default_values_or_replaces_and_gets_value
    # --- Default Attributes ---
    default = Board.new
    assert_equal 4, default.size
    empty = {}
    assert_equal empty, default.positions
    # --- Assigned Attributes ---
    assigned = Board.new(6)
    assert_equal 6, assigned.size
  end


  # --- Build Board ---

  def test_it_creates_row_headers
    default = Board.new
    expected = ["A", "B", "C", "D"]
    assert_equal expected, default.rows

    assigned = Board.new(2)
    expected = ["A", "B"]
    assert_equal expected, assigned.rows
  end

  def test_it_creates_column_headers
    default = Board.new
    expected = [1, 2, 3, 4]
    assert_equal expected, default.columns

    assigned = Board.new(2)
    expected = [1, 2]
    assert_equal expected, assigned.columns
  end

  def test_it_creates_position_labels
    default = Board.new
    expected = [
      "A1", "A2", "A3", "A4",
      "B1", "B2", "B3", "B4",
      "C1", "C2", "C3", "C4",
      "D1", "D2", "D3", "D4"
    ]
    assert_equal expected, default.create_positions

    assigned = Board.new(2)
    expected = [
      "A1", "A2",
      "B1", "B2"
    ]
    assert_equal expected, assigned.create_positions
  end

  def test_it_can_initialize_positions_with_default_states
    board = Board.new(2)
    positions = board.positions
    assert_equal empty = {}, positions
    board.initialize_positions

    # # --- Demonstrate all details for one position
    assert_equal false, positions[:A1][:player_map][:shot]
    assert_equal false, positions[:A1][:player_map][:hit]
    assert_equal nil,   positions[:A1][:player_map][:ship]
    assert_equal false, positions[:A1][:enemy_map][:shot]
    assert_equal false, positions[:A1][:enemy_map][:hit]
    # assert_equal nil, positions[:A1][:enemy_map][:ship]

    # --- Demonstrate a detail for each other position
    assert_equal false, positions[:A2][:player_map][:shot]
    assert_equal nil,   positions[:B1][:player_map][:ship]
    assert_equal false, positions[:B2][:enemy_map][:hit]
  end

  def test_it_can_anchor_ship
    # skip
    # This probably belongs in a better section, maybe other class
    board = Board.new(2)
    board.initialize_positions
    position1 = board.positions[:A1]
    position2 = board.positions[:A2]
    # -- before --
    assert_nil position1[:player_map][:ship]
    assert_nil position2[:player_map][:ship]
    # -- after --
    board.anchor_ship(["A1", "A2"])
    assert_instance_of Ship, position1[:player_map][:ship]
    assert_instance_of Ship, position2[:player_map][:ship]
  end

  def test_it_can_update_player_map_with_enemy_shots
    skip  # see end for TO DO
    board = Board.new(2)
    positions = board.positions
    board.initialize_positions
    # -- Before hit --
    assert_equal false, positions[:A1][:player_map][:shot]
    # -- After hit --
    board.update_player_map("A1")
    assert_equal true, positions[:A1][:player_map][:shot]
    assert_equal false, positions[:A1][:player_map][:hit]
    # TO DO - test shot HIT when we can place ships
  end

  def test_it_can_update_actualizations_of_enemy_map
    # skip # see end for TO DO
    board = Board.new(2)
    positions = board.positions
    board.initialize_positions
    # -- Before hit --
    assert_equal false, positions[:A1][:enemy_map][:shot]
    # -- After Miss --
    success = false
    board.update_enemy_map("A1", success)
    assert_equal true, positions[:A1][:enemy_map][:shot]
    assert_equal false, positions[:A1][:enemy_map][:hit]
    # -- After hit --
    success = true
    board.update_enemy_map("A2", success)
    assert_equal true, positions[:A2][:enemy_map][:shot]
    assert_equal true, positions[:A2][:enemy_map][:hit]
    # TO DO - test shot HIT when we can place ships
  end





end
