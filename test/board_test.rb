require_relative 'test_helper.rb'

require 'pry'

require './lib/board.rb'



class BoardTest < Minitest::Test

  def test_it_exists
    assert_instance_of Board, Board.new
  end

  def test_it_sets_size_default_and_gets_it
    assert_equal 4, Board.new.size
    assert_equal 6, Board.new(6).size
  end

  # --- New Board ---

  def test_it_can_reset_game
    board = Board.new
    board.reset_game
    # --- Rows --- (array of arrays)
    assert_equal 4, board.current_board.count
    # --- Columns --- (array of column values)
    assert_equal 4, board.current_board[1].count
    # --- Index of moves ---
    assert_equal 1, board.index
  end

  def test_it_can_create_row_headers_based_on_size
    assert_equal ["A", "B", "C", "D"], Board.new.rows
  end

  def test_it_can_create_column_headers_based_on_size
    assert_equal [1, 2, 3, 4], Board.new.cols
  end

  # --- Positions ---

  def test_it_can_create_an_array_of_all_possible_moves
    board = Board.new(2)
    actual = board.possible_moves
    expected = ["A1", "A2", "B1", "B2"]
    assert_equal expected, actual
  end

  def test_it_can_create_a_hash_of_the_board_status_at_each_position
    board = board = Board.new(2)
    board.initialize_positions
    default_hash = {is_ship: false, was_targetted: false}
    expected = {
      A1: default_hash,
      A2: default_hash,
      B1: default_hash,
      B2: default_hash
    }
    assert_equal expected, board.board_hash
  end



  # --- Manipulating Board ---



  # --- For Printing ---

  def test_it_can_print_the_board
    skip
  end

  def test_it_can_assess_rows_for_hits_or_misses
    skip
    board = Board.new(2)
    # board.assess_rows
    assert_equal [[" ", " "], [" ", " "]], board.assess_rows

  end


  def test_it_can_build_rows_by_adding_row_headers_and_new_line_characters
    skip
    board = Board.new(3)
    board.blank_board
    binding.pry
    expected = [["A", " ", " ", " "], ["B", " ", " ", " "], ["C", " ", " ", " "]]
    assert_equal expected, board.build_rows
  end

  def test_it_can_build_headers_for_columns
    assert_equal [" .", 1, 2, 3, 4, "\n"], Board.new.build_header
  end








end
