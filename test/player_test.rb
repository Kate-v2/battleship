require_relative 'test_helper.rb'

require './lib/player'
require './lib/board'
require './lib/ship'


class PlayerTest

  def test_it_exists
    assert_instance_of Player, Player.new(true)
  end

  def test_it_gets_attributes
    pc = Player.new(false)
    human = Player.new(true)
    assert_equal false, pc.is_human
    assert_equal true, human.is_human
  end




end
