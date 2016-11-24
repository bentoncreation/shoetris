module Tetris
  class ZPiece < BasePiece
    def color
      "#f00"
    end

    private

    def default_shape
      Array[
        [true, true, false],
        [false, true, true],
      ]
    end
  end
end
