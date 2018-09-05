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
    pc2 = Player.new(false, [3, 3])
    human = Player.new(true)
    assert_equal false, pc.is_human
    assert_equal true, human.is_human
    assert_instance_of Board, pc.board
    assert_instance_of Board, human.board
    assert_equal [2, 3], pc.ships
    assert_equal [3, 3], pc2.ships
  end

  def test_it_starts_game
    pc = Player.new(false)
    pc.start_game
    # details for each position are initialized
    assert_equal 16, pc.board.positions.count
  end


  # --- Ship Placement ---

  def test_it_can_place_all_ships
    skip
  end

  def test_it_can_place_a_ship
    skip
  end

  def test_it_can_process_input_coordinates
    human = Player.new(true)
    arr = human.process_coordinates("A1 A2")
    assert_equal ["A1", "A2"], arr
  end

  def test_it_can_determine_user_ship_placement_path
    skip
    # pc.placement_type
  end


  # --- Computer ----

  def test_it_can_computer_place_ships
    skip
    pc = Player.new(false)
    # FIND SHIPS objects or flags in Board
  end


  def test_it_can_print_to_screen_and_pass_turn
    skip
    # HOW TO TEST ??
  end

  def test_it_can_do_a_random_shot
    pc = Player.new(false)
    pc.start_game
    coord = pc.random_shot
    positions = pc.board.positions.keys
    actual = positions.include?(coord)
    assert_equal true, actual
    assert_equal 1, [coord].flatten.count
  end


  # --- Prompt User ----



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
