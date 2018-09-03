# Create a class for the battleship Board functionality

require 'pry'
# require 'matrix'


class Board
  attr_reader :size, :current_board

  def initialize(size = 4)
    @size = size
    @current_board = []
    # @current_board = [[" ", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", " "]]
  end

  def blank_board
    string = " " * @size
    array = string.chars
    @current_board.clear
    @size.times { |n| @current_board << array }
    binding.pry
  end



  def possible_moves
    rows = self.rows
    # matrix
  end

  def rows
    alpha = ('A'..'Z').to_a
    headers = alpha.first(@size)
  end

  def cols
    (1..@size).to_a
  end





  # --- Manipulating Board ---

  def move(position)
    # find position
    # update position attributes
    # look at / affect ship
    #
  end

  # Visual impact for printing
  def update_board #(current_board)
    # replace position with H/M
  end



  # --- For Printing ---

  def print_board #(current_board)
    # current_board is array of arrays
    # binding.pry  # @current_board is blank

    board = self.build_rows
    # binding.pry
    header = self.build_header
    board.insert(0, header)
    print board.join(" ")
    # binding.pry
    return board
  end

  def build_rows #(current_board)
    row_lead = self.rows
    # binding.pry  # @current_board is blank
    # board = @current_board.dup # --> DUP MAKES A SHALLOW COPY ??!??!
    # binding.pry  # @current_board is blank
    board.each { |row|
      row.insert(0, row_lead[0])
      row.insert(-1, "\n")
      row_lead.shift
      binding.pry
    }
    # binding.pry
    return board
  end

  def build_header
    row = self.cols
    row.insert(0, " .")
    row.insert(-1, "\n")
  end




  # . 1 2 3 4
  # A
  # B
  # C
  # D

  # A1 A2 A3 A4
  # B1 B2 B3 B4
  # C1 C2 C3 C4
  # D1 D2 D3 D4

  # p mat = Matrix[*current_board]





end
