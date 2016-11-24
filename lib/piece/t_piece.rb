module Tetris
  class TPiece < BasePiece
    def color
      "#c0f"
    end

    private

    def default_shape
      Array[
        [true, true, true],
        [false, true, false],
      ]
    end
  end
end
