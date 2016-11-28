module Tetris
  class Map
    attr_reader :grid, :background_color, :unit_size, :width, :height
    attr_accessor :rendered, :pieces

    def initialize(renderer = Proc.new {})
      @renderer = renderer
      @grid = default_grid
      @pieces = []

      @renderer.call(self)
    end

    def background_color
      "#efefef"
    end

    def left
      0
    end

    def top
      0
    end

    def unit_size
      40
    end

    def width
      10
    end

    def height
      15
    end

    def update_piece(piece)
      piece.shape.each_with_index do |row, row_index|
        row.each_with_index do |col, col_index|
          grid[row_index + piece.top][col_index + piece.left] = piece if col
        end
      end
    end

    def debug_grid
      puts grid.map {|row| row.map(&:to_s).join(" ") }.join("\n")
    end

    private

    def default_grid
      Array.new(height) { Array.new(width, false) }
    end
  end
end
