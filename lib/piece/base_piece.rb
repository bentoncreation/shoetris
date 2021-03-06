require "securerandom"

module Tetris
  class BasePiece
    attr_reader :color, :id
    attr_accessor :left, :top, :left_px, :top_px, :bottom, :shape, :renderer, :remover, :debugger

    def initialize(map, renderer = Proc.new {}, remover = Proc.new {}, debugger = Proc.new {})
      @id = SecureRandom.uuid
      @shape = default_shape
      @map = map
      @renderer = renderer
      @remover = remover
      @debugger = debugger
      update_position(0, 0)
      render
    end

    def blocked_down?
      @map.collision_at?(self, @shape, @left, @top + 1)
    end

    def update_position(left, top)
      @left = left
      @top = top
    end

    def left_px
      left * unit_size
    end

    def top_px
      top * unit_size
    end

    def fill_color
      "#000"
    end

    def stroke_color
      "#333"
    end

    def stroke_width
      2
    end

    def unit_size
      @map.unit_size
    end

    def move_left
      move_to(@left - 1, @top)
      render
    end

    def move_right
      move_to(@left + 1, @top)
      render
    end

    def rotate
      rotated_shape = @shape.transpose.reverse
      return false if @map.collision_at?(self, rotated_shape, left, top)
      @shape = rotated_shape
      render
    end

    def move_down
      move_to(@left, @top + 1)
      render
    end

    def move_to(left, top)
      return false if @map.collision_at?(self, @shape, left, top)
      update_position(left, top)
      @map.remove_piece(self)
      @map.update_piece(self)
    end

    def render
      derender
      @rendered = @renderer.call(fill_color, stroke_color, stroke_width,
                                 rectangles)
    end

    def derender
      return if @rendered.nil?
      @remover.call(@rendered)
      # @rendered = nil
    end

    def rectangles
      rectangles = []
      shape.each_with_index do |row, y|
        row.each_with_index do |col, x|
          next unless col
          rectangles << Rectangle.new(left_px + x * unit_size,
                                      top_px + y * unit_size,
                                      unit_size,
                                      unit_size)
        end
      end
      rectangles
    end

    def debug(message)
      @debugger.call(message)
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
