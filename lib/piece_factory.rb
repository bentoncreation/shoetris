module Tetris
  class PieceFactory
    PIECE_CLASSES = [IPiece, JPiece, LPiece, OPiece, SPiece, TPiece, ZPiece]

    def self.build(map, renderer = Proc.new {}, shape_renderer = Proc.new {}, shape_remover = Proc.new {})
      PIECE_CLASSES.sample.new(map, renderer, shape_renderer, shape_remover)
    end
  end
end
