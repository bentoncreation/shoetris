require "securerandom"

module Tetris
  class BasePiece
    attr_reader :color, :id
    attr_accessor :left, :top, :left_px, :top_px, :bottom, :shape, :rendered

    def initialize(map, renderer = Proc.new {}, shape_renderer = Proc.new {}, shape_remover = Proc.new {})
      @id = SecureRandom.uuid
      @shape = default_shape
      @map = map
      @renderer = renderer
      @shape_renderer = shape_renderer
      @shape_remover = shape_remover
      update_position(0, 0)
      render
    end

    def blocked_down?
      @map.collision_at?(self, @left, @top + 1)
    end

    def update_position(left, top)
      @left = left
      @top = top
    end

    def left_px
      left * 40
    end

    def top_px
      top * 40
    end

    def block_attributes(x, y)
      [
        left_px + x * unit_size,
        top_px + y * unit_size,
        unit_size,
        unit_size
      ]
    end

    def color
      "#000"
    end

    def unit_size
      40
    end

    def move_left
      move_to(@left - 1, @top)
      render
    end

    def move_right
      move_to(@left + 1, @top)
      render
    end

    def move_up
    end

    def move_down
      move_to(@left, @top + 1)
      render
    end

    def move_to(left, top)
      return false if @map.collision_at?(self, left, top)
      update_position(left, top)
      @map.remove_piece(self)
      @map.update_piece(self)
    end

    def render
      @renderer.call(self)
    end

    def render_piece
      derender_piece

      piece.rendered = @shape_renderer.call(color,
                                            col_index * unit_size,
                                            row_index * unit_size,
                                            unit_size,
                                            unit_size)

      shape do
        fill piece.color
        piece.shape.each_with_index do |row, y|
          row.each_with_index do |col, x|
            rect_builder(piece.block_attributes(x, y)) if col
          end
        end
      end
    end

    def derender_piece
      return if rendered.nil?
      @shape_remover.call(rendered)
    end

    private

    def default_shape
      Array[
        [true, true],
        [true, true],
      ]
    end
  end
end
