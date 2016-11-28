module Tetris
  class PieceFactory
    PIECE_CLASSES = [IPiece, JPiece, LPiece, OPiece, SPiece, TPiece, ZPiece]

    def self.build(map, renderer = Proc.new {})
      PIECE_CLASSES.sample.new(map, renderer)
    end
  end
end
