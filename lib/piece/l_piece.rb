module Tetris
  class LPiece < BasePiece
    def color
      "#f93"
    end

    private

    def default_shape
      Array[
        [true, true, true],
        [true, false, false],
      ]
    end
  end
end
