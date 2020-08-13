# Homework assignment 6 | UWpartC | by SID 2020
# University of Washington, Programming Languages, Homework 6, hw6runner.rb

## TODO fix bug when cheat block stays on the screen

class MyPiece < Piece

  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end

  def self.next_cheat_piece (board)
    MyPiece.new([[0,0]], board)
  end

  # adds 3 more pieces
  All_My_Pieces =
    All_Pieces + [
    [[[0, 0], [-1, 0], [1, 0], [2, 0], [-2, 0]],         # 5 blocks line
     [[0, 0], [0, -1], [0, 1], [0, 2], [0, -2]]],
    rotations([[0, 0], [1, 0], [2, 0], [0, 1], [1, 1]]), # square with appendicitis
    rotations([[0, 0], [0, 1], [1, 0]]) ]                # 3 block corner
end

class MyBoard < Board

  # rotates the current piece 180 degrees
  def rotate_180
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 2)
    end
    draw
  end

  # checks if player has cheated and gets next piece
  def next_piece
    if @is_cheated
    then
      @current_block = MyPiece.next_cheat_piece(self)
      @is_cheated = false
    else
      @current_block = MyPiece.next_piece(self)
    end
      @current_pos = nil
  end

  # decreases score by 100 if player cheated
  def cheat
    if !@is_cheated and @score >= 100
      @score -= 100
      @is_cheated = true
    end
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

  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def key_bindings
    super
    @root.bind('u', proc {@board.rotate_180})
    @root.bind('c', proc {@board.cheat})
  end

end
