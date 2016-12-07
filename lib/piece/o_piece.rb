module Tetris
  class OPiece < BasePiece
    def fill_color
      "#ff0"
    end

    private

    def default_shape
      Array[
        [true, true],
        [true, true],
      ]
    end
  end
end
