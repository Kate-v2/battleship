require_relative 'test_helper'

require 'pry'

require './lib/anchor'
require './lib/board'
require './lib/player'
require './lib/ship'


class AnchorTest < Minitest::Test

  def test_it_exists
    assert_instance_of Anchor, Anchor.new
  end

  def test_it_assesses_player_identity
    pc = Player.new(false)
    pc.start_game
    anchor = Anchor.new
    ships = [2, 3]
    board = pc.board
    positions = board.positions
    # -- place 2 ships --
    anchor.assess_player(pc)
    pc_after = positions.count { |key, val|
      positions[key][:player_map][:ship] != nil
    }
    assert_equal 5, pc_after

    human = Player.new(true)
    human.start_game
    board = human.board
    positions = board.positions
    # -- place 2 ships --
    anchor.assess_player(human)
    human_after = positions.count { |key, val|
      positions[key][:player_map][:ship] != nil
    }
    assert_equal 5, human_after
  end
#
  def test_it_can_place_all_ships
    anchor = Anchor.new
    human = Player.new(true)
    human.start_game
    board = human.board
    positions = board.positions

    # -- before adding --
    before1 = positions[:A1][:player_map][:ship] == nil
    before2 = positions[:A2][:player_map][:ship] == nil
    before3 = positions[:B1][:player_map][:ship] == nil
    before4 = positions[:B2][:player_map][:ship] == nil
    before5 = positions[:B2][:player_map][:ship] == nil
    before = before1 && before2 && before3 && before4 && before5
    assert_equal true, before


    # -- after adding --
    # please enter at prompt
      # wide_2 = ["A1", "A2"]
      # wide_3 = ["B1", "B3"]
    # skip
    anchor.place_ships([2, 3], board)
    after1 = positions[:A1][:player_map][:ship] != nil
    after2 = positions[:A2][:player_map][:ship] != nil
    after3 = positions[:B1][:player_map][:ship] != nil
    after4 = positions[:B2][:player_map][:ship] != nil
    after5 = positions[:B2][:player_map][:ship] != nil
    after = after1 && after2 && after3 && after4 && after5
    assert_equal true, after
  end
#
#
  def test_it_can_place_a_ship
    anchor = Anchor.new
    human = Player.new(true)
    human.start_game
    board = human.board
    positions = board.positions
    coord = ["A1", "A2"]
    anchor.place_ship(coord, board)
    case1 = positions[:A1][:player_map][:ship] != nil
    case2 = positions[:A2][:player_map][:ship] != nil
    assert_equal true, case1 && case2
  end
#
  def test_computer_places_ships
    pc = Player.new(false)
    pc.start_game
    anchor = Anchor.new
    ships = [2, 3]
    board = pc.board
    positions = board.positions
    # -- no ships yet --
    before = positions.count { |key, val|
      positions[key][:player_map][:ship] != nil
    }
    assert_equal 0, before
    # -- place 2 ships --
    bool = anchor.computer_place_ships(ships, board)
    after = positions.count { |key, val|
      positions[key][:player_map][:ship] != nil
    }
    assert_equal 5, after
    assert_equal true, bool   # for pass turn
  end
#
  def test_it_can_pass_turn
    pc = Player.new(false)
    pc.start_game
    anchor = Anchor.new
    bool = anchor.pass_turn
    assert_equal true, bool
  end

  def test_it_can_process_coordinates
    anchor = Anchor.new
    human = Player.new(true)
    human.start_game
    arr = anchor.process_coordinates("A1 A2")
    assert_equal ["A1", "A2"], arr
  end

  def test_it_can_find_coordinates
    anchor = Anchor.new
    human = Player.new(true)
    human.start_game
    board = human.board
    coord = anchor.find_coordinate("A1 A2", board, 2)
    assert_equal ["A1", "A2"], coord

    coord = anchor.find_coordinate("B1 B3", board, 3)
    assert_equal ["B1", "B2", "B3"], coord
  end

  def test_it_can_validate_input
    anchor = Anchor.new
    human = Player.new(true)
    human.start_game
    board = human.board
    string1 = anchor.validate(2, board)
    assert_equal "A1 A2", string1

    string2 = anchor.validate(3, board)
    assert_equal "B1 B3", string2
    # TO DO - add more ways to fail it
    # see original player_test file
  end

  def test_it_can_prompt_user
    anchor = Anchor.new
    human = Player.new(true)
    human.start_game
    board = human.board

    string1 = anchor.prompt_user(2)
    assert_equal "A1 A2", string1

    string2 = anchor.prompt_user(3)
    assert_equal "B1 B3", string2
  end

  def test_it_can_assess_format
    anchor = Anchor.new
    human = Player.new(true)
    human.start_game
    board = human.board

    bool1 = anchor.assess_format("A1 A2", board, 2)
    assert_equal true, bool1

    bool2 = anchor.assess_format("A1A2", board, 2)
    assert_equal false, bool2
    # TO DO - add more ways to fail it
    # see original player_test file
  end

  def test_can_assess_diagonal
    anchor = Anchor.new
    human = Player.new(true)
    human.start_game
    board = human.board

    bool1 = anchor.assess_diagonal("A1 A2")
    assert_equal true, bool1

    bool2 = anchor.assess_diagonal("A1 B2")
    assert_equal false, bool2
    # TO DO - add more ways to fail it
    # see original player_test file
  end

  def test_it_can_assess_spacing
    anchor = Anchor.new
    human = Player.new(true)
    human.start_game
    board = human.board

    bool1 = anchor.assess_spacing("A1 A2", 2)
    assert_equal true, bool1

    bool2 = anchor.assess_spacing("A1 A3", 2)
    assert_equal false, bool2
    # TO DO - add more ways to fail it
    # see original player_test file
  end


end
