module Tetris
  class PieceFactory
    PIECE_CLASSES = [IPiece, JPiece, LPiece, OPiece, SPiece, TPiece, ZPiece]

    def self.build(map, renderer = Proc.new {}, remover = Proc.new {}, debugger = Proc.new {})
      PIECE_CLASSES.sample.new(map, renderer, remover, debugger)
    end
  end
end
