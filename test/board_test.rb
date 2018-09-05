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
    assert_equal ["A1", "A2"], position1[:player_map][:ship].coordinates
  end

  def test_it_can_update_player_map_with_enemy_shots
    board = Board.new(2)
    positions = board.positions
    board.initialize_positions
    # -- Before hits --
    assert_equal false, positions[:A1][:player_map][:shot]
    # -- After hits --
    board.anchor_ship(["A1"])
    board.update_player_map("A1")
    assert_equal true, positions[:A1][:player_map][:shot]
    assert_equal true, positions[:A1][:player_map][:hit]
  end

  def test_it_can_update_actualizations_of_enemy_map
    board = Board.new(2)
    positions = board.positions
    board.initialize_positions
    # -- Before hit --
    assert_equal false, positions[:A1][:enemy_map][:shot]
    # -- After Miss --
    board.update_enemy_map("A1", false)
    assert_equal true, positions[:A1][:enemy_map][:shot]
    assert_equal false, positions[:A1][:enemy_map][:hit]
    # -- After hit --
    board.update_enemy_map("A1", true)
    assert_equal true, positions[:A1][:enemy_map][:shot]
    assert_equal true, positions[:A1][:enemy_map][:hit]
  end


  # --- Create Valid Placements ---

  def test_it_can_create_possible_positions_for_a_ship
    board = Board.new
    board.initialize_positions

    # -- no other ships --
    choices_for_2 = board.possible_positions(2)
    assert_equal 2, choices_for_2[0].count
    assert_equal 3*4*2, choices_for_2.count

    choices_for_3 = board.possible_positions(3)
    assert_equal 3, choices_for_3[0].count
    assert_equal 2*4*2, choices_for_3.count

    # -- other ships exist --
    board.anchor_ship(["A1", "A2"])
    choices_for_3 = board.possible_positions(3)
    assert_equal (2*4*2)-4, choices_for_3.count
  end

  def test_it_can_prevent_ship_overlap
    board = Board.new
    board.initialize_positions
    # -- no other ships --
    no_nil = board.prevent_overlap
    actual = no_nil.any? { |set| set.include?(nil) }
    assert_equal false, actual
    # -- other ships exist --
    board.anchor_ship(["A1", "A2"])
    with_nil = board.prevent_overlap
    actual = with_nil.any? { |set| set.include?(nil) }
    assert_equal true, actual
  end

  def test_it_can_collect_sets
    board = Board.new(2)
    arr = [["A1", "A2"], ["B1", "B2"]]
    sets = board.collect_sets(arr, 2)
    assert_equal 4, sets.count
  end

  def test_it_can_loop_through_rows
    board = Board.new(2)
    arr = [["A1", "A2"], ["B1", "B2"]]
    sets = board.loop_through_rows_for_sets(arr, 2)
    assert_equal 2, sets.count
  end

  def test_it_can_identify_sets_by_row
    board = Board.new(2)
    row = ["A1", "A2"]
    sets = board.identify_sets_by_row(row, 2, sets = [])
    assert_equal 1, sets.count
  end


  # --- Print Board ---

  def test_it_can_print_the_board
    board = Board.new
    board.initialize_positions
    # -- Blank --
    assert_equal String, board.print_board(:player_map).class
    assert_equal String, board.print_board(:enemy_map).class
    assert_equal false, board.print_board(:enemy_map).include?("#")
    # -- With a ship --
    board.anchor_ship(["A1", "A2"])
    assert_equal String, board.print_board(:player_map).class
    assert_equal true, board.print_board(:player_map).include?("#")
  end

  def test_it_can_assign_display_characters
    skip
  end

  def test_it_can_create_a_display_character
    skip
  end

  def test_it_can_build_rows_with_headers
    skip
  end

  def test_it_can_build_a_header_row_for_column_names
    skip
  end

  def test_it_can_build_a_string_version_of_the_board_to_print
    skip
  end


  # --- Assess Progress ---

  def test_it_can_count_moves_so_far
    board = Board.new
    board.initialize_positions
    player = board.moves_so_far("player")
    enemy = board.moves_so_far("computer")
    # -- No moves --
    assert_equal 0, player
    assert_equal 0, enemy
    # -- 1 shot each --
    board.update_player_map("A1")         # --> enemy shot at player
    board.update_enemy_map("A1", false)   # --> player shot at enemy
    player = board.moves_so_far("player")
    enemy = board.moves_so_far("computer")
    assert_equal 1, player
    assert_equal 1, enemy
  end

  def test_it_can_count_remaining_critical_hits_for_player_to_win
    board = Board.new
    board.initialize_positions
    # -- assume enemy has same number of ship coords as player
    board.anchor_ship(["A1", "A2"])
    board.anchor_ship(["B1", "B2", "B3"])
    # -- no hits yet --
    moves = board.player_moves_to_win
    assert_equal 5, moves
    # -- two hits --
    board.update_enemy_map("A1", true)
    board.update_enemy_map("A2", true)
    moves = board.player_moves_to_win
    assert_equal 3, moves
  end

  def test_it_can_count_remaining_critical_hits_for_enemy_to_win
    board = Board.new
    board.initialize_positions
    # -- anchor player ships
    board.anchor_ship(["A1", "A2"])
    board.anchor_ship(["B1", "B2", "B3"])
    # -- no hits yet --
    moves = board.enemy_moves_to_win
    assert_equal 5, moves
    # -- two hits --
    board.update_player_map("A1")
    board.update_player_map("A2")
    moves = board.enemy_moves_to_win
    assert_equal 3, moves
  end

  def test_it_can_count_remaining_targets
    board = Board.new
    board.initialize_positions
    # -- assume enemy has same number of ship coords as player
    board.anchor_ship(["A1", "A2"])
    board.anchor_ship(["B1", "B2", "B3"])
    # -- no hits yet --
    player_moves = board.remaining_targets(:player_map)
    enemy_moves = board.remaining_targets(:enemy_map)
    assert_equal 5, player_moves
    assert_equal 5, enemy_moves
    # -- Player hit twice --
    board.update_player_map("A1")
    board.update_player_map("A2")
    player_moves = board.remaining_targets(:player_map)
    assert_equal 3, player_moves
    # -- Enemy hit once --
    board.update_enemy_map("A2", true)
    enemy_moves = board.remaining_targets(:enemy_map)
    assert_equal 4, enemy_moves
  end

  def test_it_can_get_all_hit_positions
    board = Board.new
    board.initialize_positions
    # -- setup player board --
    board.anchor_ship(["A1", "A2"])
    board.anchor_ship(["B1", "B2", "B3"])
    # -- hit player twice --
    board.update_player_map("A1")
    board.update_player_map("A2")
    player_hash = board.critically_hit(:player_map)
    assert_instance_of Hash, player_hash
    assert_equal 2, player_hash.count
    assert_equal [:A1, :A2], player_hash.keys
    # binding.pry   # --> see hash stored at player_hash
    # -- hit enemy once --
    board.update_enemy_map("A2", true)
    enemy_hash = board.critically_hit(:enemy_map)
    assert_equal 1, enemy_hash.count
    assert_equal [:A2], enemy_hash.keys
  end

  def testi_it_can_get_all_player_ships
    board = Board.new
    board.initialize_positions
    # -- setup player board --
    board.anchor_ship(["A1", "A2"])
    board.anchor_ship(["B1", "B2", "B3"])
    player_hash = board.find_all_player_ship_coordinates
    assert_instance_of Hash, player_hash
    assert_equal 5, player_hash.count
    assert_equal [:A1, :A2, :B1, :B2, :B3], player_hash.keys
    # binding.pry   # --> see hash stored at player_hash
  end



























end
