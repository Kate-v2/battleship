# Create a class for normal Game play functionality
require 'pry'

require './lib/board'
require './lib/player'
require './lib/ship'


class Game

  def initialize
    @pc = Player.new(false)
    @human = Player.new(true)
  end

  def menu
    puts "Welcome to BATTLESHIP\n"
    print "Would you like to (p)lay, read the (i)nstructions, or (q)uit?\n> "
    choice = $stdin.gets.chomp
    assess_mode(choice)
  end

  def assess_mode(choice)
    if choice == "p" || "play"
      play
    elsif choice == "i" || "instructions"
      instructions
    elsif choice == "q" || "quit"
      return
    else
      puts "Oops, something went wrong. Please choose again."
    end
  end

  def play
    pc = Player.new(false)
    pc.start_game
    human = Player.new(true)
    human.start_game
    # start timer  # https://ruby-doc.org/core-2.3.0/Time.html
    loop(human, pc)
  end

  def instructions
    print "Sorry, you probably won't enjoy this game. Give up now."
  end

  # def go(pc, human)
  #   pc.place_ships
  #   human.place_ships
  #   human.board.print_board(:enemy_map)
  #   human.
  #
  # end

  def loop(player, enemy)
    player.board.print_board(:enemy_map) if player.is_human
    string = player.prompt_shot
    success = enemy.feedback(string)
    player.board.update_enemy_map(string, success)
    loop(enemy, player)
  end



end
