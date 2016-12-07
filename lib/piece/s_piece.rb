module Tetris
  class SPiece < BasePiece
    def fill_color
      "#0f0"
    end

    private

    def default_shape
      Array[
        [false, true, true],
        [true, true, false],
      ]
    end
  end
end
