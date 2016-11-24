module Tetris
  class JPiece < BasePiece
    def color
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
