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



end
