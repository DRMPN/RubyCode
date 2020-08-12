# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece

  def initialize (point_array,board)
    super
  end

  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end

  All_My_Pieces = All_Pieces + [
    [[[0, 0], [-1, 0], [1, 0], [2, 0], [-2, 0]],         # 5 blocks line
     [[0, 0], [0, -1], [0, 1], [0, 2], [0, -2]]],
    rotations([[2, 0], [0, 0], [1, 0], [0, 1], [1, 1]]), # square with appendicitis
    rotations([[0, 0], [0, 1], [1, 0]]) ]                # 3 block corner

end

class MyBoard < Board

  def initialize(game)
    super
    @current_block = MyPiece.next_piece(self)
  end

  # rotates the current piece 180 degrees
  def rotate_180
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 2)
    end
    draw
  end

  def next_piece
    @current_block = MyPiece.next_piece(self)
    @current_pos = nil
  end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    array_size = locations.length
    (0..(array_size - 1)).each{|index|
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] =
        @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end
end

class MyTetris < Tetris

  def initialize
    super
    my_key_bindings
  end

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def my_key_bindings
    @root.bind('u', proc {@board.rotate_180})
    # for cheat block
    @root.bind('c', proc {})
  end

end
