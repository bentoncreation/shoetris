module Tetris
  class IPiece < BasePiece
    def fill_color
      "#0ff"
    end

    private

    def default_shape
      Array[
        [true, true, true, true],
        [false, false, false, false],
      ]
    end
  end
end
