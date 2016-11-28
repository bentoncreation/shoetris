module Tetris
  class Map
    attr_reader :background_color, :unit_size, :width, :height
    attr_accessor :grid, :rendered, :pieces

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
      piece.shape.map.with_index do |row, row_index|
        row.each_with_index do |col, col_index|
          grid[row_index + piece.top][col_index + piece.left] = piece if col
        end
      end
    end

    def collision_at?(piece, left, top)
      piece.shape.each_with_index do |row, row_index|
        row.each_with_index do |col, col_index|
          y = row_index + top
          x = col_index + left
          next unless col
          return true if y < 0 || y >= height
          return true if x < 0 || x >= width
          # puts "grid[#{y}][#{x}] #{grid[y][x]}"
          return true unless grid[y][x] == piece || grid[y][x] == false
        end
      end

      return false
    end

    def remove_piece(piece)
      grid.map! { |row| row.map { |col| col == piece ? false : col } }
    end

    def debug_grid
      puts grid.map { |row| row.map(&:to_s).join(" ") }.join("\n")
    end

    def update_rows
      clear_filled_rows
      add_missing_rows
      pieces.map(&:render)
    end

    def clear_filled_rows
      grid.delete_if { |row| row.none? { |col| col == false } }
    end

    def add_missing_rows
      missing_rows = height - grid.size
      return if missing_rows < 1
      missing_rows.each do
        grid.unshift(Array.new(width, false))
      end
    end

    private

    def default_grid
      Array.new(height) { Array.new(width, false) }
    end
  end
end
