module Tetris
  class Map
    attr_reader :unit_size, :width, :height
    attr_accessor :grid, :pieces, :current_piece

    def initialize(renderer = Proc.new {}, remover = Proc.new {}, debugger = Proc.new {})
      @renderer = renderer
      @remover = remover
      @debugger = debugger
      @grid = default_grid
      @pieces = []
      @rendered = []

      render_background
      generate_new_piece
      render_grid
    end

    def generate_new_piece
      update_rows
      @current_piece.derender unless @current_piece.nil?

      new_piece = Tetris::PieceFactory.build(self, @renderer, @remover,
                                             @debugger)
      @pieces << new_piece
      @current_piece = new_piece

      if collision_at?(@current_piece, @current_piece.shape,
                       @current_piece.left, @current_piece.top)
        return false
      else
        return true
      end
    end

    def fill_color
      "#efefef"
    end

    def stroke_color
      "#333"
    end

    def stroke_width
      2
    end

    def left
      0
    end

    def top
      0
    end

    def unit_size
      30
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

    def collision_at?(piece, shape, left, top)
      shape.each_with_index do |row, row_index|
        row.each_with_index do |col, col_index|
          y = row_index + top
          x = col_index + left
          next unless col
          return true if y < 0 || y >= height
          return true if x < 0 || x >= width
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
    end

    def clear_filled_rows
      grid.delete_if { |row| row.none? { |col| col == false } }
    end

    def add_missing_rows
      missing_rows = height - grid.size
      return if missing_rows < 1

      missing_rows.times do
        grid.unshift(Array.new(width, false))
      end

      render_grid
    end

    def render_background
      @renderer.call(fill_color, stroke_color, stroke_width,
                     background_rectangle)
    end

    def background_rectangle
      Rectangle.new(left, top, width * unit_size, height * unit_size)
    end

    def render_grid
      derender_grid

      grid.each_with_index do |row, row_index|
        row.each_with_index do |col, col_index|
          next unless col && col != @current_piece
          @rendered << @renderer.call(col.fill_color,
                                      col.stroke_color,
                                      col.stroke_width,
                                      Rectangle.new(col_index * unit_size,
                                                    row_index * unit_size,
                                                    unit_size,
                                                    unit_size))
        end
      end
    end

    def derender_grid
      return if @rendered.empty?
      @rendered.map { |render| @remover.call(render) }
      @rendered.clear
    end

    def debug(message)
      @debugger.call(message)
    end

    private

    def default_grid
      Array.new(height) { Array.new(width, false) }
    end
  end
end
