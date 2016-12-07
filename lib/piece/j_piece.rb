module Tetris
  class JPiece < BasePiece
    def fill_color
      "#00f"
    end

    private

    def default_shape
      Array[
        [true, true, true],
        [false, false, true],
      ]
    end
  end
end
