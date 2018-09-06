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
    # skip
    pc = Player.new(false)
    human = Player.new(true)
    assert_equal "r" , Anchor.assess_player(pc)
    assert_equal "p" , Anchor.assess_player(human)
  end




end
