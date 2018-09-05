require_relative 'test_helper.rb'

require './lib/player'
require './lib/board'
require './lib/ship'


class PlayerTest < Minitest::Test

  def test_it_exists
    assert_instance_of Player, Player.new(true)
  end

  def test_it_gets_attributes
    pc = Player.new(false)
    human = Player.new(true)
    assert_equal false, pc.is_human
    assert_equal true, human.is_human
    assert_instance_of Board, pc.board
    assert_instance_of Board, human.board
  end


  # --- Ship Placement ---

  def test_it_can_process_input_coordinates
    human = Player.new(true)
    arr = human.process_coordinates("A1 A2")
    assert_equal ["A1", "A2"], arr
  end



  # --- Ship Placement Validation ---

  def test_it_can_validate_ship_placement
    skip
    human = Player.new(true)
    valid = "A1 B1"
    invalid = "A1 B2"

    assert_equal true, human.validate_ship_placement(valid, 2)
    assert_nil human.validate_ship_placement(invalid, 2)
  end


  def test_it_can_assess_format_of_ship_placement
    human = Player.new(true)

    valid = ["A1 A2", "A1-A2", "A1*A2"]

    invalid_case = "a1 a2"
    invalid_size = [" ", "A1", "A1A2", " A1 A2 "]
    invalid_form = ["A1A2 ", " A1A2",]
    invalid_content = ["AAAAA", "11111", "A1234", "123A1"]

    all_valid = valid.all? { |input| human.assess_format(input) }
    assert_equal true, all_valid

    assert_equal false, human.assess_format(invalid_case)

    all_invalid_size = invalid_size.all? { |input| human.assess_format(input) == false }
    assert_equal true, all_invalid_size

    all_invalid_form = invalid_form.all? { |input| human.assess_format(input) == false }
    assert_equal true, all_invalid_form

    all_invalid_content = invalid_content.all? { |input| human.assess_format(input) == false }
    assert_equal true, all_invalid_content
  end

  def test_it_can_assess_diagonal_placement
    human = Player.new(true)
    valid = "A1 B1"
    invalid = "A1 B2"
    assert_equal true, human.assess_diagonal(valid)
    assert_equal false, human.assess_diagonal(invalid)
  end

  def test_it_can_assess_space_between_coordinates
    human = Player.new(true)
    valid_1 = "A1 B1"
    valid_2 = "B1 B2"
    invalid_1 = "A1 A3"
    invalid_2 = "A1 A1" # demonstrates if same coordinate is entered twice
    invalid_3 = "A1 C1"
    invalid_4 = "A2 A1" # demonstrates if order is incorrect

    assert_equal true, human.assess_spacing(valid_1, 2)
    assert_equal true, human.assess_spacing(valid_2, 2)
    assert_equal true, human.assess_spacing(valid_2, 2)
    assert_equal false, human.assess_spacing(invalid_1, 2)
    assert_equal false, human.assess_spacing(invalid_2, 2)
    assert_equal false, human.assess_spacing(invalid_3, 2)
    assert_equal false, human.assess_spacing(invalid_4, 2)
  end

  def test_it_can_assess_coordinate_set_as_possible
    skip
    human = Player.new(true)
    valid_1 = "A1 B1"
    invalid_1 = "A1 A3"

    assert_equal true,  human.assess_possible(valid_1)
    assert_equal false, human.assess_possible(invalid_1)
  end


end

  # def test_it_can_place_ships
  #   skip
  #   pc = Player.new(false)
  #   human = Player.new(true)
  #   # This will do many things
  #   #   - create 2 ships
  #   #   - give each ship coordinates to hold
  #   #   - place ships on board
  # end




  # --- Ship Placement Validation ---

    #
    # def test_it_can_validate_ship_placement
    #   skip
    # end
